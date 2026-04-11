==============================================
  TALKFLO — SETUP GUIDE
==============================================

REQUIREMENTS:
  - Python 3.11+  →  https://www.python.org/downloads/
  - Node.js 18+   →  https://nodejs.org/

==============================================
  HOW TO RUN (2 windows needed)
==============================================

WINDOW 1 — Start the AI Agent:
  Double-click: agent\START_AGENT.bat

WINDOW 2 — Start the Demo Website:
  Double-click: agent\START_DEMO_SITE.bat

Then open: http://localhost:3000
Click "Start Voice Call" to test.

==============================================
  KEYS ARE PRE-CONFIGURED
==============================================

All API keys are already in agent\.env
No extra setup needed.

==============================================
  DEPLOYING TO VERCEL
==============================================

1. Push this folder to GitHub
2. Import on vercel.com
3. Add these env vars in Vercel dashboard:

   LIVEKIT_URL=wss://agent-ai-o3myov9n.livekit.cloud
   LIVEKIT_API_KEY=APIkXNr7pXYi7RX
   LIVEKIT_API_SECRET=fgxg4KFjwHoa3re8fznrBZSNekNvGzdhZ1ue47fx88GL
   NEXT_PUBLIC_LIVEKIT_URL=wss://agent-ai-o3myov9n.livekit.cloud

4. The agent (Python) still needs to run on your machine or a server.
   For production, host it on a VPS (e.g. DigitalOcean, Railway).