#!/bin/bash                                                                   
 set -e                                                                        
                                                                                
 chown -R openclaw:openclaw /data                                              
 chmod 700 /data                                                               
                                                                                
  if [ ! -d /data/.linuxbrew ]; then                    
    cp -a /home/linuxbrew/.linuxbrew /data/.linuxbrew                           
  fi                                                    

  rm -rf /home/linuxbrew/.linuxbrew
  ln -sfn /data/.linuxbrew /home/linuxbrew/.linuxbrew

  # Fix: restream POST body consumed by express.json() before http-proxy
  sed -i '/setHeader.*Origin.*GATEWAY_TARGET/a\  if(req.body){const
  b=JSON.stringify(req.body);proxyReq.setHeader("Content-Length",Buffer.byteLeng
  th(b));proxyReq.write(b);}' /app/src/server.js

exec gosu openclaw node src/server.js
