#!/usr/bin/python
print("This might create a bunch of inserts, also it might not. Torren isn't really good at python")
fileOut = open("Rooms.txt", "w")
smoking=0
bedType="Full"
num_beds=1
for x in range(1,201):
	bedType="Full"
	if x%2==0:
		smoking=1
		bedType="Full"
	else:
		smoking=0
		bedType="Twin"
	if x%5==0:
		bedType="King"
		num_beds=1
	elif x%7==0:
		if num_beds:
			num_beds=2
		bedType="Queen"
	fileOut.write("INSERT INTO GUEST_ROOM VALUES(" + str(x) + ", " + str(num_beds) + ", '"	+ bedType + "', " + str(smoking) + ");\n")
fileOut.close()
print("Done... maybe?")
		
	
		