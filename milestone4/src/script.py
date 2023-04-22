import subprocess
import os
i=1
dir_path = input("Enter directory path:")
# print(cmd)
for path in reversed(os.listdir(dir_path)):
    os.system('make sym'+'<'+dir_path+'/'+ path)
    ocm='make run'
    os.system(ocm)
    os.system('./out < '+dir_path+'/'+ path+' >> '+path+'.txt')