from paramiko import SSHClient
from paramiko import pkey
import paramiko
import sys

arg = sys.argv[1] #Taking comma separated hostnames as arguments
hostnames = arg.split(',') #Splitting with , to get Hostnames
cmd = raw_input("Enter the command : ") #Getting the command ehich would be executed
key = paramiko.RSAKey.from_private_key_file("/home/krunal_merwana/.ssh/id_rsa") #Getting the private key which would match with public on host machine
ssh = SSHClient() #Initiating SSHClient
ssh.load_system_host_keys() #Loading Host keys
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy()) # Client doesn't add the policy so we need add the missing one
for name in hostnames: #Looping the hostnames
    print("In "+name)
    ssh.connect(hostname=name,port = 22,username="krunal_merwana",pkey=key) #Connecting to the host machine
    ssh.invoke_shell() #invoking shell
    ssh_stdin, ssh_stdout, ssh_stderr = ssh.exec_command(cmd) #Executing the cmd which user inputs into host machine 
    print("Command Output on "+name)
    print(ssh_stdout.read()) #print the output of ls command
