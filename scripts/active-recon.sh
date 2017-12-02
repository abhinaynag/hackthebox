nmap -e tun0 -n4 -sn 10.10.10.0/24 -oA ../global_results/livehosts
nmap -e tun0 -n4 -sn -PR  10.10.10.0/24 -oA ../global_results/livehosts -append-output
nmap -e tun0 -n4 -sn -PU  10.10.10.0/24 -oA ../global_results/livehosts -append-output
nmap -e tun0 -n4 -sn -PS  10.10.10.0/24 -oA ../global_results/livehosts -append-output

cat ../global_results/livehosts.gnmap | awk '!seen[$0]++' | grep Host | cut -d " " -f2 > ../global_results/livehosts.txt

cat ../global_results/livehosts.txt | while read ip ; do mkdir ../$ip; done

cat ../global_results/livehosts.txt | while read ip; do nmap -e tun0 -sV -v -Pn $ip --oA ../$ip/$ip-services

cat ../global_results/livehosts.txt | while read ip; do $(searchsploit -x --nmap ../$ip/$ip-services.xml > ../$p/$ip-exploits.txt);  $( searchsploit -x --nmap -j ../$ip/$ip-services.xml > ../$ip/$ip-exploits.json ) ; ;done;

