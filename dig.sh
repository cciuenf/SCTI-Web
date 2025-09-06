#!/bin/bash
# debug-connectivity.sh

echo "🔍 Diagnosing connectivity issues..."

# Check if containers are running
echo "📦 Checking container status:"
docker-compose --profile prod ps

echo -e "\n🌐 Testing local connectivity:"

# Test HTTP (port 80)
echo "Testing HTTP (port 80):"
curl -I http://localhost/ 2>/dev/null && echo "✅ HTTP works" || echo "❌ HTTP fails"

# Test HTTPS (port 443)
echo "Testing HTTPS (port 443):"
curl -I https://localhost/ -k 2>/dev/null && echo "✅ HTTPS works" || echo "❌ HTTPS fails"

# Test backend directly
echo "Testing backend API:"
curl -I http://localhost/api/health 2>/dev/null && echo "✅ API reachable" || echo "❌ API not reachable"

echo -e "\n🔗 Testing external domain:"

# Test domain resolution
echo "Domain resolution:"
nslookup sctiuenf.com.br

# Test external HTTP
echo "External HTTP:"
curl -I http://sctiuenf.com.br/ --connect-timeout 10 2>/dev/null && echo "✅ External HTTP works" || echo "❌ External HTTP fails"

# Test external HTTPS
echo "External HTTPS:"
curl -I https://sctiuenf.com.br/ --connect-timeout 10 -k 2>/dev/null && echo "✅ External HTTPS works" || echo "❌ External HTTPS fails"

echo -e "\n🔧 Checking nginx configuration:"
docker-compose --profile prod exec nginx nginx -t 2>/dev/null && echo "✅ Nginx config valid" || echo "❌ Nginx config invalid"

echo -e "\n📋 Checking SSL certificates:"
docker-compose --profile prod exec certbot ls -la /etc/letsencrypt/live/ 2>/dev/null || echo "❌ No SSL certificates found"

echo -e "\n🔍 Checking nginx logs (last 10 lines):"
docker-compose --profile prod logs --tail=10 nginx
