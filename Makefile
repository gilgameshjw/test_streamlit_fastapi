# Makefile

# Variables
PYTHON = python3
PIP = pip3
FASTAPI_DIR = app
STREAMLIT_DIR = streamlit_app

# Install dependencies
install:
	$(PIP) install -r requirements.txt

# Run FastAPI backend
run-backend:
	cd $(FASTAPI_DIR) && uvicorn main:app --reload

# Run Streamlit frontend
run-frontend:
	cd $(STREAMLIT_DIR) && streamlit run app.py

# Run both backend and frontend
run:
	make run-backend &
	make run-frontend

# Clean up (remove Python cache files)
clean:
	find . -type d -name "__pycache__" -exec rm -rf {} +
	rm -rf ./*.log

# Default target
help:
	@echo "Available commands:"
	@echo "  make install       - Install dependencies"
	@echo "  make run-backend   - Run FastAPI backend"
	@echo "  make run-frontend  - Run Streamlit frontend"
	@echo "  make run           - Run both backend and frontend"
	@echo "  make clean         - Clean up cache files"

# Run both backend and frontend using tmux
run-tmux:
	tmux new-session -d -s fastapi-streamlit 'make run-backend'
	tmux split-window -h 'make run-frontend'
	tmux attach-session -t fastapi-streamlit

