import re 

path = '/app/src/server.js'    
with open(path, 'r') as f:   
    code = f.read()


old = 'proxyReq.setHeader("Origin", GATEWAY_TARGET);\n});'
new = 'proxyReq.setHeader("Origin", GATEWAY_TARGET);\n  if(req.body){const b=JSON.stringify(req.body);proxyReq.setHeader("Content-Length",Buffer.byteLength(b));proxyReq.write(b);}\n});'


code = code.replace(old, new, 1)

with open(path, 'w') as f:
    f.write(code)
print("[patch] proxy body restream fix applied")




