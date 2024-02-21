# sd-gopostal

If needing help please do join my discord below

**discord for support - [https://discord.gg/GB3QJRDSEx](https://discord.gg/TwfWs6wmMt)**

## Features
- Fast setup based!
- Easy Config.lua

## Installation

***Job Names Setup***
goto > resources\[qb]\qb-core\shared > and add the code below add it to any part of your .lua code

```
gopostal = {
        label = 'GoPostal',
        type = 'gopostal',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            ['0'] = { name = 'Recruit', payment = 50 },
        },
    },
```


***Item Name Setup***
goto > resources\[qb]\qb-core\shared > and add the code below add it to any part of your .lua code

```
    gopostalpapers                    = { name = 'gopostal_papers', label = 'GoPostal Papers', weight = 1000, type = 'item', image = 'gopostal.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'This is the GoPostal Papers' },
```


***Cityhall Setup***
goto > resources\[qb]\qb-cityhall > and add the code below at **Config.AvailableJobs**

```
['gopostal'] = { ['label'] = 'GoPostal', ['isManaged'] = false }
```

```
ensure sd-gopostal
```
