# WhatsApp Transcription Bot

This project sets up a WhatsApp bot using the `open-wa/wa-automate` library to transcribe audio messages in group chats and private messages.

You can find more information about Whisper.cpp here: [Whisper.cpp GitHub Repository](https://github.com/ggerganov/whisper.cpp).

You need `ffmpeg` installed to convert audio files: [FFmpeg Official Website](https://ffmpeg.org).

## Instructions

### Configure Environment Variables
Add the group IDs to your `.env` file, separated by commas.

You can also use `*` for the app to transcribe messages in every group chat. Example: `GROUPS=*`

The app will automatically transcribe private messages.

### How to Find Group ID
In the file `index.js`, uncomment the `if` block to log the group ID in your Docker console.

### Using Docker (Recommended Method)
Docker provides an isolated environment that ensures all dependencies are correctly installed and configured. Follow these steps to set up and run the bot using Docker:

1. **Install Docker**:
   - Download and install Docker from the [Docker Official Website](https://www.docker.com).
   - Follow the installation instructions for your operating system.

2. **Build the Docker Image**:
   Open a terminal and navigate to the project directory. Then run the following command:
   ```bash
   docker build -t whatsapp-transcription-bot .
   ```

3. **Run the Docker Container**:
   ```bash
   docker run -d --name whatsapp-transcription-bot --env-file .env whatsapp-transcription-bot
   ```

4. **Monitor Docker Logs**:
   - **For Windows and Docker Desktop Users**:
     - Open Docker Desktop.
     - Navigate to **Containers** and click on the running container named `whatsapp-transcription-bot`.
     - This opens the **Logs** screen where you can scan the QR code to link your device. You will also see the Group IDs if you have logging enabled.
   - **For Command Line Users**:
     - Monitor the logs using the following command:
       ```bash
       docker logs -f whatsapp-transcription-bot
       ```
     - Look for the QR code in the logs and scan it using WhatsApp's option to link a device.

### Using Locally
1. **Install Dependencies**:
   ```bash
   npm install
   ```

2. **Run the Application**:
   ```bash
   node index.js
   ```

   **The console will show a QR code that you need to scan using WhatsApp's option to link a device.**
   **When you link your device, you need to wait for the application to sync with WhatsApp. This may take a while.**
   **It will be ready when you see this message in the console:**

   ```
   🚀 @OPEN-WA ready for account: XXXX
   ```

Enjoy.

## Troubleshooting
- Ensure all dependencies are correctly installed.
- Verify environment variables in the `.env` file.
- Check Docker and application logs for error messages.

## Additional Notes
- **FFmpeg**: Ensure FFmpeg is installed on your system for audio conversion.
- **Whisper.cpp**: This project uses Whisper.cpp for transcription, which requires a model file (`ggml-small.bin`). The Dockerfile handles the setup of Whisper.cpp and its dependencies.
- **Transcription**: The bot automatically handles transcription for private messages and configured group chats.