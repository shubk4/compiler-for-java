import subprocess
import os
i=1
dir_path = input("Enter directory path:")
os.system("make clean")
os.system("mkdir ../output")
# print(cmd)
for path in reversed(os.listdir(dir_path)):
    os.system('make')
    os.system('echo "strict graph{ " > '+path+'.dot')
    os.system('./out < '+dir_path+'/'+ path + ' >> ' + path +'.dot')
    os.system('echo "}" >> '+path + '.dot')
    os.system('dot -Tpng ' + path + '.dot > ../output/'+ path+ '.png')