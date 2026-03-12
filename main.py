import logging
import os
from dotenv import load_dotenv
from livekit.agents import (
    Agent,
    AgentSession,
    JobContext,
    WorkerOptions,
    cli,
    RoomInputOptions,
)
from livekit.plugins import deepgram, groq, silero

load_dotenv()

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger("voice-agent")

SYSTEM_PROMPT = """
You are a friendly and professional AI voice assistant for a demo.

Your job is to have a natural, helpful conversation with the caller.
You can help with:
- Answering questions about the VoiceAI product and its features
- Booking or scheduling demos
- Explaining pricing plans (Starter $49/mo, Growth $149/mo, Scale $499/mo)
- General Q&A

TONE: Warm, concise, and natural. Keep responses short — this is a voice call.
Never say you're an AI unless directly asked. Just be helpful.

PRICING:
- Starter: $49/month — 100 minutes, 1 agent
- Growth: $149/month — 500 minutes, 5 agents
- Scale: $499/month — 2000 minutes, unlimited agents

Technical details if asked: built on LiveKit, Groq LPU, Deepgram STT, Groq TTS.
Response latency under 200ms.
"""

class DemoAgent(Agent):
    def __init__(self):
        super().__init__(instructions=SYSTEM_PROMPT)

async def entrypoint(ctx: JobContext):
    logger.info(f"Agent starting for room: {ctx.room.name}")

    await ctx.connect()

    session = AgentSession(
        vad=silero.VAD.load(),
        stt=deepgram.STT(model="nova-2", language="en-US"),
        llm=groq.LLM(model="llama-3.3-70b-versatile", temperature=0.7),
        tts=groq.TTS(model="playai-tts", voice="Celeste-PlayAI"),
        allow_interruptions=True,
        min_endpointing_delay=0.5,
    )

    await session.start(
        room=ctx.room,
        agent=DemoAgent(),
        room_input_options=RoomInputOptions(),
    )

    await session.generate_reply(
        instructions="Greet the user warmly and ask how you can help them today."
    )

if __name__ == "__main__":
    cli.run_app(WorkerOptions(entrypoint_fnc=entrypoint))
