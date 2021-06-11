import pygame
#initialize pygame modules
pygame.init()
#load image
img = pygame.image.load('example-1024.png')
#text that will print and its size
text = 'Осипенко Д.В.'
size = 70
#generate image
#greq offset
color_offset = int(256/len(text))
temp = (0,0,0)#start color
img_rect = img.get_rect().center#pygame rectangle of img for getting center
for t,j in zip(text,range(len(text))):
    #draw every letter on img surface
    img.blit((pygame.font.SysFont('calibry',size)).render(t,False,temp),[img_rect[0]/3+j*size/1.5,img_rect[1]-size/2])
    #set new rgb gray color
    temp = tuple([i + color_offset for i in temp])

#save new image
pygame.image.save(img,'OsipenkoDV.png')
    