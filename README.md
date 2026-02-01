# ☁️ CloudMail Pro

A premium full-stack Mail Service and Cloud Storage platform built with Node.js, TypeScript, and a beautiful Glassmorphism UI.

## ✨ Features

### 📧 Mail Service
- Send emails via SMTP integration
- Support for multiple email providers (Gmail, Outlook, Yahoo, etc.)
- Rich HTML email support
- Clean, intuitive interface

### 💾 Cloud Storage
- Upload files up to 10MB
- View and manage all uploaded files
- Download files on-demand
- Delete unwanted files
- Real-time file listing

### 🎨 Design
- High-end Glassmorphism aesthetic
- Frosted glass effects with backdrop blur
- Animated mesh gradient backgrounds
- Fully responsive design
- Smooth transitions and animations

## 🚀 Quick Start

### Prerequisites
- Node.js (v16 or higher)
- npm or yarn
- Linux shared hosting with Phusion Passenger (for deployment)

### Local Development

1. **Clone or extract the project**
```bash
cd cloudmail-pro
```

2. **Install dependencies**
```bash
npm install
```

3. **Configure environment variables**
```bash
cp .env.example .env
# Edit .env and add your SMTP credentials
```

4. **Run in development mode**
```bash
npm run dev
```

5. **Build for production**
```bash
npm run build
```

6. **Start production server**
```bash
npm start
```

Access the application at `http://localhost:3000`

## 🌐 Deployment to Shared Hosting

### One-Click Deployment

We've created an automated deployment script for easy installation on Linux shared hosting with Phusion Passenger.

1. **Upload files to your server**
```bash
# Via FTP/SFTP, upload all files to your hosting account
# Recommended location: ~/cloudmail-pro
```

2. **Make the deploy script executable**
```bash
chmod +x deploy.sh
```

3. **Run the deployment script**
```bash
./deploy.sh
```

The script will automatically:
- ✅ Check Node.js and npm installation
- ✅ Create necessary directories
- ✅ Install dependencies
- ✅ Build TypeScript to JavaScript
- ✅ Configure .htaccess for Passenger
- ✅ Set proper file permissions
- ✅ Create utility scripts

### Manual Deployment Steps

If you prefer manual deployment:

1. **Install dependencies**
```bash
npm install --production
```

2. **Build the application**
```bash
npm run build
```

3. **Configure .htaccess**
```
PassengerEnabled on
PassengerAppType node
PassengerStartupFile dist/server.js
PassengerAppRoot /home/username/cloudmail-pro
```

4. **Update .env with SMTP credentials**
```bash
nano .env
# Add your email provider settings
```

5. **Set permissions**
```bash
chmod -R 755 .
chmod -R 777 uploads
chmod 600 .env
```

6. **Point your domain**
Configure your hosting control panel to point your domain to the `public` directory.

## 🔧 Configuration

### SMTP Setup

The application supports various email providers. Update `.env` with your credentials:

**Gmail**
```env
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=your-email@gmail.com
SMTP_PASS=your-app-password
```

**Outlook/Hotmail**
```env
SMTP_HOST=smtp.office365.com
SMTP_PORT=587
```

**Yahoo**
```env
SMTP_HOST=smtp.mail.yahoo.com
SMTP_PORT=587
```

**Custom SMTP**
```env
SMTP_HOST=your-smtp-server.com
SMTP_PORT=587
```

### Gmail Setup Guide

1. Enable 2-Factor Authentication in your Google Account
2. Generate an App Password: https://myaccount.google.com/apppasswords
3. Use the generated password in `.env`

## 📁 Project Structure

```
cloudmail-pro/
├── server.ts              # Main server file
├── dist/                  # Compiled JavaScript (generated)
│   └── server.js
├── public/                # Static files
│   └── index.html        # Glassmorphism UI
├── uploads/              # Uploaded files storage
├── package.json          # Dependencies
├── tsconfig.json         # TypeScript config
├── .htaccess            # Passenger configuration
├── deploy.sh            # Deployment script
├── .env.example         # Environment template
└── README.md            # This file
```

## 🛠️ Available Scripts

```bash
# Development
npm run dev          # Run with ts-node

# Production
npm run build        # Compile TypeScript
npm start           # Start production server

# Utility (created by deploy.sh)
./restart.sh        # Restart Passenger app
./view-logs.sh      # View application logs
```

## 🔐 Security Notes

- Never commit `.env` file to version control
- Use strong, unique SMTP passwords
- Keep dependencies updated
- Enable HTTPS on your domain
- The `uploads` directory is publicly accessible - consider adding authentication

## 📊 API Endpoints

### Mail Service
```
POST /api/mail/send
Body: { to, subject, text, html }
```

### Cloud Storage
```
POST /api/storage/upload     # Upload file
GET  /api/storage/files       # List files
GET  /api/storage/download/:filename
DELETE /api/storage/files/:filename
```

## 🎨 UI Customization

The glassmorphism design uses Tailwind CSS. To customize:

1. Edit `public/index.html`
2. Modify the gradient in `.mesh-gradient` class
3. Adjust glass effects in `.glass-card` and `.glass` classes
4. Update colors in Tailwind utility classes

## ❓ Troubleshooting

### "Cannot send email"
- Verify SMTP credentials in `.env`
- Check if your email provider allows SMTP access
- For Gmail, ensure you're using an App Password

### "Upload fails"
- Check `uploads` directory permissions (should be 777)
- Verify file size is under 10MB
- Ensure sufficient disk space

### "Application not loading"
- Run `./restart.sh` to restart Passenger
- Check logs: `./view-logs.sh`
- Verify `.htaccess` paths are correct

### "Build errors"
- Delete `node_modules` and `dist` folders
- Run `npm install` again
- Ensure TypeScript is installed

## 📄 License

MIT License - Feel free to use and modify

## 🤝 Support

For issues or questions about deployment:
1. Check the troubleshooting section
2. Review server logs
3. Verify all configuration files are correct

## 🔄 Updates

To update the application:
```bash
# Pull latest changes
# Run deployment script again
./deploy.sh
```

---

Built with ❤️ using Node.js, TypeScript, Express, and Tailwind CSS
