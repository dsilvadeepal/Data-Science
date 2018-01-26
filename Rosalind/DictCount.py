s = "When I find myself in times of trouble Mother Mary comes to me Speaking words of wisdom let it be And in my hour of darkness she is standing right in front of me"
strlist = s.split()

dictnew ={}

for key in strlist:
    if key in dictnew:
        dictnew[key] += 1
    else:
        dictnew[key] = 1


for k, v in dictnew.items():
    print(k + ' ' + str(v))
