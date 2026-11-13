if grep TODO "$1" > /dev/null; then
  echo "Found TODOs"
else
  echo "No TODOs found"
fi
