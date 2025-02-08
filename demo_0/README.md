# simple demo setup

```
                                                      +--> ap-south-1a
                                                      |                   +--> instance-0
alb -> target group listener -> target group -> vpc --+--> ap-south-1b ---+
                                                      |                   +--> instance-1
                                                      +--> ap-south-1c


```