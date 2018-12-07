#coding=gbk

import urllib2
import urllib
import urllib3
import datetime
import time
import hashlib
import traceback
import json
import sys
import re
import pinyin
import copy
import base64
import string
import math
import jieba
import getvector as gv
import tornado.ioloop as _Ioloop
import tornado.web as _Web
import tornado.httpserver
import tornado.ioloop
import tornado.web
import tornado.httpclient
import tornado.gen
from tornado.concurrent import run_on_executor
from concurrent.futures import ThreadPoolExecutor

def getres(path, ressize, resfrom):
	headers = {'Content-Type': 'application/json'}
	esipport = 'localhost/elst/'
	url="http://" + esipport + "/infocenter1/weixin/_search?timeout=15ms"
	res = "{}"
	reqstr = ""
	try:
		queries = []
		for line in open(path):
			segs = line.strip().decode('gbk','ignore').split('\t')
			if len(segs) != 2:
				continue
			term = segs[0]
			value = float(segs[1])
			queries.append({
				"multi_match" : {
					"query":      term,
					"type":       "phrase",
					"fields":     [ "text^0.5", "title^1.2" ],
					"boost":	  value
				}
			})
		req = {
			"size": ressize,
			"from": resfrom,
			"_source": [
				"title",
				"text",
				"account",
				"title_score",
				"account_weight",
				"page_time",
				"video_sig",
				"url",
				"img_list",
				"lda",
				"video_time",
				"account_lda",
				"read_level",
				"spread_rate",
				"cn_num"
			],
			"query" : {
				 "function_score": {
				 	"query":{
						"dis_max" : {
						 	"boost" : 1,
						 	"queries" : queries
						},
					},
					"boost": "1",
					"functions": [
						{
							"filter": {
								"bool": {
									"must_not": {
										"term": {
											"account.keyword": u"知乎"
												}
												}
										}
										},
							"gauss": {
								"page_time": {
									"origin": "now",
									"scale": "60d",
									"offset": "3d"
											}
										}
						},
						{
							"filter": {
								"bool": {
									"must": {
										"term": {
											"account.keyword": u"知乎"
												}
											}
										}
									},
							"weight": 0.5
						},
						{
							"filter": {
								"bool": {
									"must": {
										"term": {
											"account.keyword": u"知乎"
											}
										}
									}
								},
							"field_value_factor": {
								"field":    "praise_num",
								"modifier": "ln2p",
								"factor": 0.05
								}
						},
						{
							"field_value_factor": {
						        "field":    "title_score",
								"modifier": "log1p"
					     	}
						},
						{
							"field_value_factor": {
						        "field":    "account_weight",
								"modifier": "log2p",
						        "factor": 1
					     	}
						},
						{
							"filter": {
								"bool": {
									"should": [
										{
											"term": {
												"host.keyword": "www.zhihu.com"
											}
										},
										{
											"term": {
												"host.keyword": "mp.weixin.qq.com"
											}
										}
									]
								}
							},	
							"field_value_factor": {
								"field":    "read_level",
								"factor": 0.5
							}
						},
						{
							"filter": {
								"bool": {
									"must_not": [
										 {
										 	"term": {
												"host.keyword": "www.zhihu.com"
											}
										},
										{
											"term": {
												"host.keyword": "mp.weixin.qq.com"
											}
										}
									]
								}
							},
							"weight": 2
						},
						{
							"filter": {
								"range": {
									"loc_level": {
										"gte": 4
									}
								}
							},
							"weight": 0
						},
						{
						  "filter": {
						    "range": {
						      "black_level": {
						        "gte": 5
						      }
						    }
						  },
						  "weight": 0
						},
						{
						  "filter": {
						    "range": {
						      "cn_num": {
						        "lt": 200
						      }
						    }
						  },
						  "weight": 0
						},

					],
					"boost_mode":"multiply"
				}
			}
		}
		reqstr = json.dumps(req)
		reqinfo = json.dumps(req, indent=4, ensure_ascii=False)
		poolmanager = urllib3.PoolManager(num_pools=10, maxsize=300)
		r = poolmanager.request('POST', url, body=reqstr)
		res = r.data
	except Exception,e:
		print Exception,":",e
		traceback.print_exc()
		print "REQSTR"
		print reqstr
	return res

if __name__ == "__main__":
	file_path = sys.argv[1]
	ressize = int(sys.argv[2])
	resfrom = int(sys.argv[3])
	res = getres(file_path, ressize, resfrom)
	print res.decode('utf-8','ignore').encode('gbk','ignore')
