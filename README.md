# WhatsApp Transcription Bot

This project sets up a WhatsApp bot using the `open-wa/wa-automate` library to transcribe audio messages in group chats and private messages.

## Prerequisites

Before you can use this application, make sure you have:

1. **A WhatsApp Account**: You must have an active WhatsApp account on your mobile device. This application will link to your existing WhatsApp account as an additional device.

2. **Access to Your Mobile Device**: You'll need your phone to scan a QR code during the setup process to link this bot to your WhatsApp account.

3. **System Requirements**:
   - Node.js (if running locally)
   - Docker (recommended for easier setup)
   - Internet connection for initial setup and synchronization

## How It Works

This bot connects to your WhatsApp account as a linked device (similar to WhatsApp Web). Once connected, it:
- Monitors audio messages in private chats and configured group chats
- Automatically transcribes audio messages using Whisper.cpp AI model
- Sends the transcription back as a text message in the same chat

**Important**: This bot will have access to your WhatsApp messages, so only use it in environments you trust.

## Setup Instructions

### Step 1: Configure Environment Variables

Create a `.env` file in the project directory and configure which chats to transcribe:

```bash
# To transcribe messages in ALL group chats and private messages:
GROUPS="*"

# OR to transcribe only specific group chats (you'll need to find the Group IDs first):
# GROUPS="groupId1@g.us,groupId2@g.us"
```

**Notes**:
- The app will **always** transcribe private messages (direct messages)
- Use `GROUPS="*"` to transcribe audio in all group chats
- Use specific group IDs (separated by commas) to transcribe only certain groups

### Step 2: How to Find Group IDs (Optional)

If you want to transcribe only specific group chats instead of all groups:

1. In the file `index.js`, find and uncomment this block of code:
   ```javascript
   // if(message.isGroupMsg){
   //     const groupName = message.chat?.contact?.name || '';
   //     const groupId= message.chatId;
   //     console.log(`Group name: ${groupName} | Group ID: ${groupId}`)
   // }
   ```

2. Run the application (see steps below)
3. Send a message in the group chat you want to monitor
4. Check the console logs to see the Group ID
5. Add the Group ID to your `.env` file

### Step 3: Choose Your Installation Method

#### Option A: Using Docker (Recommended)
Docker provides an isolated environment that ensures all dependencies are correctly installed and configured.

1. **Install Docker**:
   - Download and install Docker from the [Docker Official Website](https://www.docker.com)
   - Follow the installation instructions for your operating system

2. **Build the Docker Image**:
   Open a terminal and navigate to the project directory. Then run:
   ```bash
   docker build -t whatsapp-transcription-bot .
   ```

3. **Run the Docker Container**:
   ```bash
   docker run -d --name whatsapp-transcription-bot --env-file .env whatsapp-transcription-bot
   ```

4. **Link Your WhatsApp Account**:
   You need to scan a QR code to link your WhatsApp account to this bot:
   
   - **For Windows and Docker Desktop Users**:
     - Open Docker Desktop
     - Navigate to **Containers** and click on the running container named `whatsapp-transcription-bot`
     - This opens the **Logs** screen where you can scan the QR code to link your device
   
   - **For Command Line Users**:
     - Monitor the logs using:
       ```bash
       docker logs -f whatsapp-transcription-bot
       ```
     - Look for the QR code in the logs
   
   - **To Link Your Device**:
     - Open WhatsApp on your mobile device
     - Go to Settings → Linked Devices
     - Tap "Link a Device"
     - Scan the QR code displayed in the logs
   
   - **Wait for Synchronization**:
     - After scanning, wait for the application to sync with WhatsApp (this may take several minutes)
     - You'll know it's ready when you see: `🚀 @OPEN-WA ready for account: XXXX`

#### Option B: Running Locally

**Prerequisites for Local Setup**:
- Node.js installed on your computer
- FFmpeg installed on your system ([FFmpeg Official Website](https://ffmpeg.org))

1. **Install Dependencies**:
   ```bash
   npm install
   ```

2. **Run the Application**:
   ```bash
   node index.js
   ```

2. **Link Your WhatsApp Account**:
   - The console will display a QR code
   - Open WhatsApp on your mobile device
   - Go to Settings → Linked Devices
   - Tap "Link a Device"
   - Scan the QR code displayed in the console
   
4. **Wait for Synchronization**:
   - After scanning, wait for the application to sync with WhatsApp (this may take several minutes)
   - You'll know it's ready when you see: `🚀 @OPEN-WA ready for account: XXXX`

**Note**: When running locally, you need to ensure FFmpeg is installed on your system for audio conversion. The Docker method handles this automatically.

## Usage

Once the bot is set up and connected:

1. **Send Audio Messages**: Send voice messages in private chats or configured group chats
2. **Get Transcriptions**: The bot will automatically transcribe the audio and reply with the text
3. **Monitor Logs**: Check the console/Docker logs to see transcription activity

The bot will transcribe audio messages in:
- All private/direct messages (always enabled)
- Group chats specified in your `.env` file (or all groups if using `GROUPS="*"`)

## Troubleshooting

**Common Issues**:

- **QR Code Not Appearing**: Restart the application and wait a few moments for the QR code to generate
- **"WhatsApp account not connected"**: Make sure you've scanned the QR code with your mobile device
- **Audio not transcribing**: Ensure the audio format is supported and the message is in a monitored chat
- **Docker container stops unexpectedly**: Check Docker logs for error messages using `docker logs whatsapp-transcription-bot`

**General Steps**:
- Ensure all dependencies are correctly installed
- Verify environment variables in the `.env` file
- Check Docker and application logs for error messages
- Make sure your WhatsApp account is active and connected to the internet

## Technical Details

**Dependencies and Technologies**:
- **FFmpeg**: Required for audio file conversion (automatically installed in Docker)
- **Whisper.cpp**: Used for AI-powered transcription ([GitHub Repository](https://github.com/ggerganov/whisper.cpp))
- **Model File**: Uses `ggml-small.bin` model for transcription (downloaded automatically in Docker)
- **Node.js**: Runtime environment for the application

**How Transcription Works**:
1. Audio messages are detected and downloaded
2. Audio is converted to WAV format using FFmpeg
3. Whisper.cpp processes the audio and generates text transcription
4. The transcription is sent back as a reply in the same chat
5. Temporary files are cleaned up automatically

**Privacy and Security**:
- This bot connects to your WhatsApp account as a linked device
- It processes audio messages locally (no data sent to external services)
- Audio files are temporarily stored during processing and then deleted
- Only use this bot in trusted environments