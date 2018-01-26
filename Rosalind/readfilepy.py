with open('rosalind_ini5.txt', 'r') as f:
    count = 0
    for line in f:
        count+=1
        if count % 2 == 0: #this is the remainder operator
            print(line)
