# sd-gopostal

If needing help please do join my discord below

**discord for support - [https://discord.gg/GB3QJRDSEx](https://discord.gg/TwfWs6wmMt)**

FOR NOW THIS IS ONLY FOR QBCORE I WILL PUSH A UPDATE FUTHER IN THE FUTURE FOR ESX

P.S - This is my very first script from scratch... i will add third eye for post boxes in the future too.

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


***Inventory Setup***
goto > [qb]\qb-inventory\html\images > and add the gopostal.png


```
inside of the [image] folder
```

```
ensure sd-gopostal

inside of the fxmanifest.lua you can undash the ox-lib if using ox-lib for targets!
```
