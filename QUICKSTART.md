# 🚀 Quick Deployment Guide - CloudMail Pro

## For Shared Hosting (Recommended)

### Step 1: Upload Files
Upload all files to your hosting account via FTP/SFTP to a directory like:
```
/home/yourusername/cloudmail-pro
```

### Step 2: SSH into Your Server
```bash
ssh yourusername@yourserver.com
cd cloudmail-pro
```

### Step 3: Run One-Click Deploy
```bash
chmod +x deploy.sh
./deploy.sh
```

### Step 4: Configure Email
```bash
nano .env
```
Update these lines:
```
SMTP_USER=your-email@gmail.com
SMTP_PASS=your-app-password
```

### Step 5: Point Your Domain
In your hosting control panel:
- Set Document Root to: `/home/yourusername/cloudmail-pro/public`
- Save changes

### Step 6: Access Your App
Visit: `https://yourdomain.com`

---

## For VPS/Dedicated Server

### Step 1: Install Node.js
```bash
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs
```

### Step 2: Clone/Upload Project
```bash
cd /var/www
git clone your-repo cloudmail-pro
# OR upload files via SCP
```

### Step 3: Install & Build
```bash
cd cloudmail-pro
npm install
npm run build
```

### Step 4: Configure Environment
```bash
cp .env.example .env
nano .env
# Update SMTP credentials
```

### Step 5: Run with PM2 (Process Manager)
```bash
npm install -g pm2
pm2 start dist/server.js --name cloudmail-pro
pm2 save
pm2 startup
```

### Step 6: Setup Nginx Reverse Proxy (Optional)
```nginx
server {
    listen 80;
    server_name yourdomain.com;

    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
```

---

## Gmail SMTP Setup (Most Common)

1. Go to: https://myaccount.google.com
2. Enable 2-Factor Authentication
3. Go to: https://myaccount.google.com/apppasswords
4. Create an app password for "Mail"
5. Use this password in your `.env` file

---

## Troubleshooting

**Can't send emails?**
- Check SMTP credentials in `.env`
- For Gmail, use App Password (not regular password)
- Verify SMTP settings for your provider

**Upload not working?**
- Check `uploads` folder permissions: `chmod 777 uploads`
- Verify file size is under 10MB

**App not loading?**
- Restart: `touch tmp/restart.txt` (Passenger)
- Or: `pm2 restart cloudmail-pro` (PM2)
- Check logs: `tail -f logs/*.log`

**Build errors?**
```bash
rm -rf node_modules dist
npm install
npm run build
```

---

## File Locations

- **Application**: `/home/username/cloudmail-pro`
- **Public files**: `/home/username/cloudmail-pro/public`
- **Uploads**: `/home/username/cloudmail-pro/uploads`
- **Logs**: `/home/username/cloudmail-pro/logs`
- **Config**: `/home/username/cloudmail-pro/.env`

---

## Security Checklist

✅ Update `.env` with real SMTP credentials  
✅ Never commit `.env` to Git  
✅ Enable HTTPS (Let's Encrypt recommended)  
✅ Set proper file permissions  
✅ Keep Node.js and dependencies updated  
✅ Consider adding authentication for production use  

---

## Need Help?

1. Check README.md for detailed documentation
2. Review error logs
3. Verify all configuration files
4. Test SMTP connection separately

---

**That's it! Your CloudMail Pro platform is ready! 🎉**
