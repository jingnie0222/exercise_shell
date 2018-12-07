#!/bin/sh

(cd dir1/ && tar cf - .) | (cd dir2/ && tar xpvf -)
