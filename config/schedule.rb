every :hour do
  command "wget -O ~/fablab_inventory/inventory.csv https://docs.google.com/a/bitsushi.com/spreadsheet/pub\?key\=0AtIlZyLn99e6dGRleUJTY043a3FucUhFUVVBYTdxS3c\&single\=true\&gid\=0\&output\=csv"
  command "cd ~/fablab_inventory && git add inventory.csv && git commit inventory.csv -m 'inventory update' && git push"
end
