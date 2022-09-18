# redireciona o output para o crontab atual
crontab -l > minha_cron

# Faz o backup todo dia as 6 da manhã
echo "00 06 * * * mysqldump -h 127.0.0.1 -u root -proot gerenciamento_conferencia > ~/backup.sql" >> minha_cron

# Instalar o novo cron
crontab minha_cron
rm minha_cron