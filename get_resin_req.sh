cat searchhub.err.log.* | grep "HttpRequestMessage::Resin Request" | awk '{print $5}' > tupu_resin_0419
