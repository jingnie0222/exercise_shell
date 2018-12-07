#!/bin/sh

sleep 10 &
wait `jobs -p`
