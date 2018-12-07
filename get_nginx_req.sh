 cat searchhub.err.log.* | grep "HttpRequestMessage::Nginx Request" | awk '{print "10.144.12.98:5558" $6}'> tupu_nginx_0419
