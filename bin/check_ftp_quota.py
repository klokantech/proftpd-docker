#!/usr/bin/env python
# -*- encoding: utf-8 -*-
#
# This file is WorkInProgress. It can be used to update FTP qutota limits.

import MySQLdb
import os

_DB_HOST = os.environ['PROFTP_MYSQL_HOST']
_DB_USER = os.environ['PROFTP_MYSQL_ADMIN_USER']
_DB_PASS = os.environ['PROFTP_MYSQL_ADMIN_PASSWORD']
_DB_DB   = os.environ['PROFTP_MYSQL_DB']
db_conn = MySQLdb.connect(
		host = _DB_HOST, user=_DB_USER,
		db   = _DB_DB, passwd=_DB_PASS)
db = db_conn.cursor()

DEFAULT_QUOTA_KB = 500 * (2 ** 20) # 500 MiB
DEFAULT_QUOTA_FILES = 500

class DirCounter:
	def __init__(self, root):
		self.files  = 0
		self.bytes = 0
		self.addDir(root)

	def addDir(self, root):
		for dir,dirnames,files in os.walk(root):
			self.files += len(files)
			for f in files:
				fname = os.path.join(dir, f)
				self.bytes += os.stat(fname).st_size
		
		
def main():
	db.execute('SELECT username,homedir FROM ftpuser')
	records = db.fetchall()
	for user,homedir in records:
		db.execute('SELECT count(name) FROM ftpquotalimits '\
			'WHERE name=%s AND quota_type=%s', [user, 'user'])
		count = db.fetchone()[0]
		if not count:
			db.execute('INSERT INTO ftpquotalimits'\
					'(name,quota_type,per_session,'\
					'limit_type,'\
					'bytes_in_avail,files_in_avail) '\
				'VALUES (%s,%s,%s, %s, %s, %s)',
				[user,'user','false','soft',
					DEFAULT_QUOTA_KB,DEFAULT_QUOTA_FILES])
		#
		counter = DirCounter(homedir)
		db.execute('SELECT count(name) FROM ftpquotatallies '\
				'WHERE name=%s AND quota_type=%s', 
				[user,'user'])	
		count = db.fetchone()[0]
		if not count:
			db.execute('INSERT INTO ftpquotatallies '\
				'(name,quota_type) '\
				'VALUES (%s,%s)', [user, 'user'])	
			bytes,files = None,None
		else:
			db.execute('SELECT bytes_in_used, files_in_used '\
				'FROM ftpquotatallies '\
				'WHERE name=%s AND quota_type=%s',
					[user, 'user'])
			bytes, files = db.fetchone()
		if bytes != counter.bytes or files != counter.files:
			print('[%s]' % user)
			print('bytes: %s -> %s' % (bytes, counter.bytes))
			print('files: %s -> %s' % (files, counter.files))
			db.execute('UPDATE ftpquotatallies '\
				'SET bytes_in_used=%s, files_in_used=%s '\
				'WHERE name=%s AND quota_type=%s',
				[counter.bytes, counter.files,
					user, 'user'])


if __name__ == '__main__':
	main()
        db_conn.commit()
