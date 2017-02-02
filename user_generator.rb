#coding UTF-8

  US = ("a".."z").to_a
  RU =  File.readlines('alphabet.txt')

  def addError(s,c)
    if c
      return s.insert(rand(s.size),US[rand(US.size)])
    else
      return s.insert(rand(s.size),RU[rand(RU.size)].chomp)
    end
  end

  def addNumError(s)
    return s.insert(rand(s.size),rand(9).to_s)
  end

def removeError(s)
  if s.size<2
    return s+s[0]
  else
  a = rand(s.size)
  return s.slice!(0,a)+s.slice!(1, s.length)
  end
end

def copySymError(s)
  if s.size<1
    return s+s[0]
  else
  a=rand(s.size)
  return s.insert(a,s[a])
    end
end

def changeError(s)
  if s.size<2
    return s+s[0]
  else
  a=rand((s.size)-1)+1
  temp = s[a-1]
  s[a-1]=s[a]
  s[a]=temp
  return s
    end
end

class First
invaild_params = Array.new
region='ru'
count=1
errors=0
check = false

if ARGV.length==3 || ARGV.length==2
  if ["en.US","en.GB","ru.RU","by.BY"].include?(ARGV[0])
  region = (ARGV[0][3]+ARGV[0][4]).downcase
  if "en"==(ARGV[0][0]+ARGV[0][1]).downcase
    check=true
  end
  else
    invaild_params.push("lang.Region")
  end

  if ARGV[1].to_i>0 && ARGV[1].to_i<10000001 
    count = ARGV[1].to_i
  else
    invaild_params.push("userCount")
  end
  if ARGV[2].to_f > 0 
  errors = ARGV[2].to_f
    end
  else
    invaild_params.push("errorsCount")
  end

if(invaild_params.any?)
  puts "Not a valid parameters: "
  invaild_params.each do 
    |param| puts param
  end
  exit(0)
end
errorForOne = (errors.to_f*count.to_f)/count.to_f

cities = File.readlines(region+'_cities.txt')
streets= File.readlines(region+'_streets.txt')
names = File.readlines(region+'_name_m.txt')
surnames = File.readlines(region+'_surname_m.txt')
numbers = File.readlines(region+'_numbers.txt')
i=0
err = 0
loop do
    i+=1
    a=surnames[rand(surnames.size)].chomp
    b=names[rand(names.size)].chomp
    c=streets[rand(streets.size)].chomp
    d=(rand(200)+1).to_s
    e=(rand(500)+1).to_s
    f=cities[rand(cities.size)].chomp
    if region=="gb"
      g = numbers[rand(numbers.size)].chomp + (rand(89999)+10000).to_s
    elsif region=="us"
      g = numbers[rand(numbers.size)].chomp + (rand(899)+100).to_s+")"+(rand(8999999)+1000000).to_s
      else
      g=numbers[rand(numbers.size)].chomp
    end
    array = [a,b,c,d,e,f,g]
    if errorForOne<1
    err+=errorForOne
    else
      err = 1
end
    if errors>0
      if err>=1
    loop do
      numEl = rand(array.size)
      array[numEl] = changeError(array[numEl])
      err+=1
      break if errors<=err
      numEl = rand(array.size)#346
      if [3,4,6].include?(numEl)
        array[numEl] = addNumError(array[numEl])
      else
      array[numEl] = addError(array[numEl],check)
      end
      err+=1
      break if errors<=err
      numEl = rand(array.size)
      array[numEl] = removeError(array[numEl])
      err+=1
      break if errors<=err
      numEl = rand(array.size)
      array[numEl] = copySymError(array[numEl])
      err+=1
      break if errors<=err

      numEl = rand(array.size)
      array[numEl] = removeError(array[numEl])
      err+=1
      break if errors<=err
    end
    if errorForOne<1
        err = errorForOne
    else
      err=0
      end
    end
    end
    puts  (array[0]+' '+array[1]+'; '+array[2]+', '+array[3]+', '+array[4]+', '+array[5]+', ' +array[6]).force_encoding("windows-1251").encode("utf-8")
    break if count<=i
end
end
