patchnotes<br>
made after sunday streams 00-02 so no patch notes for those<br>
<br>
### sunday stream 04
* yet to be recorded...

### interlude 03.1
* removed navigation layer, agent and region
* un-commented aStar systems

### sunday stream 03
* added a Navigation Layer to `tml_floor_9a.gd`, painted the top 2 rows of tiles (or top 6 tiles) with it
* commented out aStar system and packed it into code regions. `expie.gd`'s is at the top, `9ACore.gd`'s is at the bottom
* added a NavigationAgent2D to `experiment.tscn` (also turned on debugging, so it should produce a pink line along its path when pathing)
* added a NavigationRegion2D to `9A.tscn`. by this i mean `tml_floor_9a.gd`'s script creates one
* deleted `testforgenorcontain` from `9A.tscn`
