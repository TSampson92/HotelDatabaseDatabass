#!/usr/bin/python
print("Figuring out what departments actually need to work...")
outFile = open("DsRInserts.txt", "w")
for roomNum in range(1,201):
	houseKeeping = "INSERT INTO DEPARTMENT_SERVICES_ROOM VALUES(" + str(1) + ", " + str(roomNum) + ");\n"
	outFile.write(houseKeeping)
	if (roomNum % 2 == 0):
		food = "INSERT INTO DEPARTMENT_SERVICES_ROOM VALUES(" + str(2) + ", " + str(roomNum) + ");\n"
		outFile.write(food)
	if (roomNum % 7 == 0):
		maintenance = "INSERT INTO DEPARTMENT_SERVICES_ROOM VALUES(" + str(3) + ", " + str(roomNum) + ");\n"
		outFile.write(maintenance)
outFile.close()
print("Done!")
	