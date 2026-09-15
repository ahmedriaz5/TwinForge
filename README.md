# TwinForge — AI Industrial Digital Twin & Predictive Maintenance Platform

TwinForge is an end-to-end smart-factory simulation platform designed as a portfolio-grade AI/ML + backend engineering project.

## Features

- Virtual factory with multiple machines
- Synthetic real-time industrial sensor simulation
- Temperature, vibration, pressure, RPM and current sensors
- Historical time-series storage in PostgreSQL (SQLite fallback is supported)
- Machine health scoring and risk scoring
- Rule-based anomaly detection
- Isolation Forest anomaly-model training utility
- Failure-risk estimation
- Maintenance recommendation engine
- Sensor history APIs
- Live REST polling dashboard
- Machine detail telemetry and charts
- **Sensor Intelligence** dashboard with live sensor flags/anomaly events
- **Maintenance Center** with active alerts and resolve actions
- **Maintenance Risk Monitor** with prioritized machine risk and recommendations
- Optional LLM explanation endpoint
- Docker Compose for PostgreSQL
- FastAPI Swagger documentation
- Pytest test suite
- Seed/demo data
- Windows one-click launcher (`START_TWINFORGE.ps1`)

## Architecture

    Sensor Simulator
          |
          v
    FastAPI Ingestion
          |
          v
      PostgreSQL / SQLite
          |
      +---+-------------------+
      |                       |
      v                       v
  ML Anomaly Utility     Health/Risk Engine
      |                       |
      +-----------+-----------+
                  v
              FastAPI REST
                  |
                  v
              React UI

## Quick start — Windows + existing PostgreSQL

### 1. Backend

PowerShell:

    cd backend
    python -m venv .venv
    .\.venv\Scripts\Activate.ps1
    pip install -r requirements.txt

Create `.env` from `.env.example` and set your PostgreSQL connection, for example:

    DATABASE_URL=postgresql+psycopg://postgres:YOUR_PASSWORD@localhost:5432/twinforge

Create the database once:

    CREATE DATABASE twinforge;

Run the API from the `backend` folder:

    uvicorn app.main:app --reload

Swagger: `http://127.0.0.1:8000/docs`

### 2. Seed factory

In a second terminal:

    cd backend
    .\.venv\Scripts\Activate.ps1
    $env:PYTHONPATH = "."
    python -m scripts.seed

### 3. Start simulator

Keep that terminal open and run:

    python -m scripts.run_simulator

### 4. Frontend

In a third terminal:

    cd frontend
    npm install
    npm run dev

Open the Vite URL shown in the terminal, usually `http://localhost:5173`.

### 5. One-click launcher

After the backend virtual environment exists and PostgreSQL/database are ready, from the project root:

    .\START_TWINFORGE.ps1

This opens separate PowerShell windows for API, simulator and frontend, and opens Swagger/dashboard in the browser.

### 6. Docker database (optional)

From the project root:

    docker compose up -d db

Then use the PostgreSQL URL from `.env.example`.

## Important

The simulator is synthetic. It is not intended for controlling real industrial equipment.

The Isolation Forest utility is a demonstration model trained on synthetic data. Real deployment requires validated industrial datasets, domain-specific thresholds, monitoring and safety controls.
