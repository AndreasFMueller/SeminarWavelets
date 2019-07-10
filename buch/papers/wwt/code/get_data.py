import pandas as pd

tables = []
j = 1
while(j < 10):
    link = 'http://www.wetter-seegraeben.ch/uploads/insert.php?insert=2017010' + str(j) + '.htm'
    print(link)
    tables += pd.read_html(link)
    j += 1 
            
while(j < 32): #nur bis 30. im Monat, ohne 31.
    link = 'http://www.wetter-seegraeben.ch/uploads/insert.php?insert=201701'+ str(j) + '.htm'
    print(link)
    tables += pd.read_html(link)
    j += 1

j = 1
while(j < 10):
    link = 'http://www.wetter-seegraeben.ch/uploads/insert.php?insert=2017020'+ str(j) + '.htm'
    print(link)
    tables += pd.read_html(link)
    j += 1
            
while(j < 29): #nur bis 30. im Monat, ohne 31.
    link = 'http://www.wetter-seegraeben.ch/uploads/insert.php?insert=201702'+ str(j) + '.htm'
    print(link)
    tables += pd.read_html(link)
    j += 1

j = 1
while(j<10):
    link = 'http://www.wetter-seegraeben.ch/uploads/insert.php?insert=2017030'+str(j) +'.htm'
    print(link)
    tables += pd.read_html(link)
    j+=1
            
while(j<32): #nur bis 30. im Monat, ohne 31.
    if(j != 29):
        link = 'http://www.wetter-seegraeben.ch/uploads/insert.php?insert=201703'+str(j) +'.htm'
        print(link)
        tables += pd.read_html(link)
    j+=1

j = 1
while(j<10):
    link = 'http://www.wetter-seegraeben.ch/uploads/insert.php?insert=2017040'+str(j) +'.htm'
    print(link)
    tables += pd.read_html(link)
    j+=1
            
while(j<31): #nur bis 30. im Monat, ohne 31.
    link = 'http://www.wetter-seegraeben.ch/uploads/insert.php?insert=201704'+str(j) +'.htm'
    print(link)
    tables += pd.read_html(link)
    j+=1

j = 1
while(j<10):
    link = 'http://www.wetter-seegraeben.ch/uploads/insert.php?insert=2017050'+str(j) +'.htm'
    print(link)
    tables += pd.read_html(link)
    j+=1
            
while(j<32): #nur bis 30. im Monat, ohne 31.
    link = 'http://www.wetter-seegraeben.ch/uploads/insert.php?insert=201705'+str(j) +'.htm'
    print(link)
    tables += pd.read_html(link)
    j+=1

j = 1
while(j<10):
    link = 'http://www.wetter-seegraeben.ch/uploads/insert.php?insert=2017060'+str(j) +'.htm'
    print(link)
    tables += pd.read_html(link)
    j+=1
            
while(j<31): #nur bis 30. im Monat, ohne 31.
    link = 'http://www.wetter-seegraeben.ch/uploads/insert.php?insert=201706'+str(j) +'.htm'
    print(link)
    tables += pd.read_html(link)
    j+=1

j = 1
while(j<10):
    link = 'http://www.wetter-seegraeben.ch/uploads/insert.php?insert=2017070'+str(j) +'.htm'
    print(link)
    tables += pd.read_html(link)
    j+=1
    print(j)
    
while(j<32): #nur bis 30. im Monat, ohne 31.
    link = 'http://www.wetter-seegraeben.ch/uploads/insert.php?insert=201707'+str(j) +'.htm'
    print(link)
    print(j)
    tables += pd.read_html(link)
    j+=1
    
j = 1
while(j<10):
    link = 'http://www.wetter-seegraeben.ch/uploads/insert.php?insert=2017080'+str(j) +'.htm'
    print(link)
    tables += pd.read_html(link)
    j+=1
            
while(j<32): #nur bis 30. im Monat, ohne 31
    link = 'http://www.wetter-seegraeben.ch/uploads/insert.php?insert=201708'+str(j) +'.htm'
    print(link)
    tables += pd.read_html(link)
    j+=1
    
j = 1
while(j<10):
    link = 'http://www.wetter-seegraeben.ch/uploads/insert.php?insert=2017090'+str(j) +'.htm'
    print(link)
    tables += pd.read_html(link)
    j+=1
            
while(j<31): #nur bis 30. im Monat, ohne 31.
    if(j != 13 and j != 14):
        link = 'http://www.wetter-seegraeben.ch/uploads/insert.php?insert=201709'+str(j) +'.htm'
        print(link)
        tables += pd.read_html(link)
    j+=1

j = 1
while(j<10):
    link = 'http://www.wetter-seegraeben.ch/uploads/insert.php?insert=2017100'+str(j) +'.htm'
    print(link)
    tables += pd.read_html(link)
    j+=1
            
while(j<32): #nur bis 30. im Monat, ohne 31.
    link = 'http://www.wetter-seegraeben.ch/uploads/insert.php?insert=201710'+str(j) +'.htm'
    print(link)
    tables += pd.read_html(link)
    j+=1

j = 1
while(j<10):
    link = 'http://www.wetter-seegraeben.ch/uploads/insert.php?insert=2017110'+str(j) +'.htm'
    print(link)
    tables += pd.read_html(link)
    j+=1
            
while(j<31): #nur bis 30. im Monat, ohne 31.
    link = 'http://www.wetter-seegraeben.ch/uploads/insert.php?insert=201711'+str(j) +'.htm'
    print(link)
    tables += pd.read_html(link)
    j+=1

j = 1
while(j<10):
    link = 'http://www.wetter-seegraeben.ch/uploads/insert.php?insert=2017120'+str(j) +'.htm'
    print(link)
    tables += pd.read_html(link)
    j+=1
            
while(j<32): #nur bis 30. im Monat, ohne 31.
    link = 'http://www.wetter-seegraeben.ch/uploads/insert.php?insert=201712'+str(j) +'.htm'
    print(link)
    tables += pd.read_html(link)
    j+=1
    


