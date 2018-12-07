#!/bin/bash

rsync -vazP 10.142.97.56::search/odin/daemon/searchhub/log/history/searchhub.err.log.2015-08-17_{01,02,03,04} .

rsync -vazP 10.142.107.44::search/odin/daemon/searchhub/log/history/searchhub.err.log.2015-08-17_{05,06,07,08} .

rsync -vazP 10.142.107.87::search/odin/daemon/searchhub/log/history/searchhub.err.log.2015-08-17_{09,10,11,12} .

rsync -vazP 10.142.113.86::search/odin/daemon/searchhub/log/history/searchhub.err.log.2015-08-17_{13,14,15,16} .

rsync -vazP 10.142.113.87::search/odin/daemon/searchhub/log/history/searchhub.err.log.2015-08-17_{17,18,19,20} .

rsync -vazP 10.142.113.88::search/odin/daemon/searchhub/log/history/searchhub.err.log.2015-08-17_{21,22,23,00} .
