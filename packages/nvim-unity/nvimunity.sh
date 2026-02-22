CONFIG_DIR="$HOME/.config/nvim-unity"
CONFIG_FILE="$CONFIG_DIR/config.json"
NVIM_PATH="nvim"
SOCKET="$HOME/.cache/nvimunity.sock"
mkdir -p "$CONFIG_DIR"

# Cria config.json se não existir
if [ ! -f "$CONFIG_FILE" ]; then
  echo '{"last_project": ""}' > "$CONFIG_FILE"
fi

# Lê last_project
LAST_PROJECT=$(jq -r '.last_project' "$CONFIG_FILE")

# Argumentos
FILE="$1"
LINE="${2:-1}"

if ! [[ "$LINE" =~ ^[1-9][0-9]*$ ]]; then
  LINE="1"
fi

# Detecta Shift pressionado (opcional com xdotool)
SHIFT_PRESSED=false
if command -v xdotool >/dev/null; then
  xdotool keydown Shift_L keyup Shift_L >/dev/null 2>&1 && SHIFT_PRESSED=true
fi

# Monta comando
if [ "$SHIFT_PRESSED" = true ] && [ -n "$LAST_PROJECT" ]; then
  CMD="$NVIM_PATH --listen $SOCKET \"+$LINE\" \"+cd \"$LAST_PROJECT\"\" $FILE"
else
  CMD="$NVIM_PATH --listen $SOCKET \"+$LINE\" $FILE"
fi

# Executa
eval "$CMD"
