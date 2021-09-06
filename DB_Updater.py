import requests
import pymysql
import pandas as pd
from bs4 import BeautifulSoup as bs
from datetime import datetime


class DBUpdater:
    def __init__(self):
        self.conn = pymysql.connect(
            host='localhost',
            user='root',
            password='Sql2021!',
            db='youtube_db',
            charset='utf8'
        )

        with self.conn.cursor() as curs:
            sql = '''
            CREATE DATABASE IF NOT EXISTS youtube_db;
            USE youtube_db;
            '''
            curs.execute(sql)

            sql = '''
            CREATE TABLE if not EXISTS youtube_db (
                title varchar(50),
                views int(20), 
                likes int(20), 
                dislikes int(20),
                comment_counts int(20),
                primary key (title)
            )
            '''
            curs.execute(sql)
            sql = '''
            CREATE TABLE if not EXISTS youtube_comments_db (
                comments varchar(50),
                likes int(20),
                primary key (comments)
            )
            '''
            curs.execute(sql)
            self.conn.commit()
            self.codes = dict()

    def __del__(self):
        pass

    def read_data(self):
        data = pd.read_csv('/Users/sollee/Desktop/youtube.csv')
        print(data.head())
        return data

    def replace_into_db(self, data):
        with self.conn.cursor() as curs:
            for r in data.itertuples():
                sql = f'REPLACE INTO  VALUES'
                curs.execute(sql)
            self.conn.commit()
            print('REPLACE into database.....OK')

    # def execute_daily(self):
    #     self.


if __name__ == '__main__':
    dbu = DBUpdater()
    # dbu.execute_daily()
