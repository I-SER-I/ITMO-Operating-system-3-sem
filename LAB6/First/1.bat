wmic os get caption, version > version
wmic computersystem get totalphysicalmemory > memory
wmic os get freephysicalmemory >> memory
wmic logicaldisk list brief > disks