for file in *.txt; do
  echo "$file TODO count: $(grep TODO "$file" | wc -l)"
done
