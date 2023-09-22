# format-dual-language

CLI to take text in two languages (e.g. text and translation) and turn it into a two-column table.

e.g., given input file bwf50-2.txt:

``` text
Men ne cunnon
secgan to soðe, selerædende,
hæleð under heofenum, hwa þæm hlæste onfeng.

Nobody knows,
to tell the truth, not counsellors in the hall,
nor heroes under the heavens, who unloaded that cargo.
```

running

``` shell
./reformat alternating --in bwf50-2.txt --out bwf50-2.out
```

produces an output file bwf50-2.out with:

``` text
|----------------------------------------------+--------------------------------------------------------|
| Men ne cunnon                                | Nobody knows,                                          |
| secgan to soðe, selerædende,                 | to tell the truth, not counsellors in the hall,        |
| hæleð under heofenum, hwa þæm hlæste onfeng. | nor heroes under the heavens, who unloaded that cargo. |
```

More variants will be added.
