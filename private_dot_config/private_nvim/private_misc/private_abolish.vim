if !exists(":Abolish")
    finish
endif

function s:name()
    let l:name = system('git config --list | rg "user.name" | cut -d "=" -f2')
    return l:name
endfunction
function s:email()
    let l:email = system('git config --list | rg "user.email" | cut -d "=" -f2')
    return l:email
endfunction
function s:firstName()
    let l:firstname = split(system('git config --list | rg "user.name" | cut -d "=" -f2'))[0]
    return l:firstname
endfunction
function s:lastName()
    let l:lastname = split(system('git config --list | rg "user.name" | cut -d "=" -f2'))[1]
    return l:lastname
endfunction

" if git config has user name
let s:has_user_name  = system('git config --list | rg "user.name" | cut -d "=" -f2')
if !v:shell_error
    if !empty(s:has_user_name)
        inoremap <expr> ;name <SID>name()
        let name_split = split(system('git config --list | rg "user.name" | cut -d "=" -f2'))
        if len(name_split) > 1
            inoremap <expr> ;fn <SID>firstName()
            inoremap <expr> ;ln <SID>lastName()
        endif
    endif
endif

" if git config has user email
let s:has_user_email  = system('git config --list | rg "user.email" | cut -d "=" -f2')
if !v:shell_error
    if !empty(s:has_user_email)
        "imap ;name name
        inoremap <expr> ;email <SID>email()
    endif
endif



Abolish facade	façade
Abolish farenheit Fahrenheit
Abolish fam{,m}il{air,ar,liar,iar}{,ize,ized,ized,izing}	fa{m}il{iar}{}
Abolish favoritted favourited
Abolish faeture{,s}	feature{}
Abolish febu{,r}ary February
Abolish efel	feel
Abolish fwe	few
Abolish feild{,s}	field{}
Abolish fianlly	finally
Abolish finalyl	finally
Abolish fidn	find
Abolish firts	first
Abolish flemmish Flemish
Abolish follwo{,ing}	follow{}
Abolish for{a,the}	for {}
Abolish foriegn	foreign
Abolish formalhaut Fomalhaut
Abolish forwrd{,s,ing,er,most}	forward{}
Abolish foward{,s,ing,er}	forward{}
Abolish foudn	found
Abolish fransiscan{s} Franciscan{s}
Abolish freind{,ly,s}	friend{}
Abolish firends	friends
Abolish frmo	from
Abolish fromthe	from the
Abolish frmo from
Abolish furneral	funeral
Abolish galations Galatians
Abolish gameboy Game Boy
Abolish gemeral	general
Abolish geting	getting
Abolish gettin	getting
Abolish ghandi Gandhi
Abolish gievn	given
Abolish giveing	giving
Abolish gloabl	global
Abolish godounov Godunov
Abolish go{ign,nig}	going
Abolish oging	going
Abolish gothenberg Gothenburg
Abolish gottleib Gottlieb
Abolish gove{n,r}ment	government
Abolish gerat	great
Abolish gruop{,s}	group
Abolish grwo	grow
Abolish garantee	guarantee
Abolish gaurd	guard
Abolish guatamala{,n} Guatemala{}
Abolish guidlines	guidelines
Abolish guili{a,o} Giuli{}
Abolish guiness Guinness
Abolish guiseppe Giuseppe
Abolish habsbourg Habsburg
Abolish hadbeen	had been
Abolish hda	had
Abolish ahppen	happen
Abolish hapen{,ed,ing,s}	happen{}
Abolish happend	happened
Abolish hallowean Halloween
Abolish {has,have}been	{} been
Abolish hsa	has
Abolish hasnt	hasn’t
Abolish hva{e,ing}	hav{}
Abolish ahve	have
Abolish haev	have
Abolish hve have
Abolish haveing	having
Abolish havin   having
Abolish he{said,was} he {}
Abolish hge	he
Abolish hearign	hearing
Abolish herat	heart
Abolish heidelburg Heidelberg
Abolish hlep	help
Abolish helpfull	helpful
Abolish hense  hence
Abolish ehr	her
Abolish hightlight                            highlight
Abolish hismelf	himself
Abolish hsi	his
Abolish ihs	his
Abolish honsetly honestly
Abolish httpL	http:
Abolish Ihave I have
Abolish idae	idea
Abolish idaes	ideas
Abolish identofy	identify
Abolish Im                                    I'm
Abolish imediat{e,ly}	immediate{,ly}
Abolish immediatly	immediately
Abolish {,re}impliment{,s,ing,ed,ation}       {}implement{}
Abolish import{en,na}t{,ly}	import{an}t{}
Abolish impossable	impossible
Abolish improv{em,me}nt{,s}	improve{me}nt{}
Abolish improvment{,s}                        improvement{}
Abolish inteh	in the
Abolish inthe	in the
Abolish inwhich	in which
Abolish infact in fact
Abolish includ	include
Abolish indenpenden{ce,t}	independen{}
Abolish independan{ce,t}	independen{}
Abolish indepedent	independent
Abolish indecate	indicate
Abolish influance	influence
Abolish infomation	information
Abolish informatoin	information
Abolish inherant{,ly}                         inherent{}
Abolish inital	initial
Abolish ititial	initial
Abolish isntall                               install
Abolish instaleld	installed
Abolish insted	instead
Abolish insurence	insurance
Abolish itnerest{,ed,int,s}	interest{}
Abolish interum	interim
Abolish is{the,is,was}	is {}
Abolish ihaca Ithaca
Abolish israelies Israelis
Abolish januray January
Abolish japanes Japanese
Abolish jugment	judgment
Abolish jospeh Joseph
Abolish juad{,a}ism Judaism
Abolish jsut	just
Abolish k{nwo,onw}{,n,s}	k{now}{}
Abolish nkow	know
Abolish knowl{d,e}ge	knowledge
Abolish labratory	laboratory
Abolish lastyear	last year
Abolish lastest                               latest
Abolish learnign	learning
Abolish lenght	length
Abolish {les,compar,compari}sion{,s}          {les,compari,compari}son{}
Abolish ltters letters
Abolish levle	level
Abolish lib{ary,arry,rery}	library
Abolish lisense	license
Abolish lieutenent	lieutenant
Abolish liuke	like
Abolish liek{,d}	like{}
Abolish likly	likely
Abolish littel	little
Abolish litttle	little
Abolish liev	live
Abolish liveing	living
Abolish lonly	lonely
Abolish lookign	looking
Abolish loev	love
Abolish lybia Libya
Abolish amde	made
Abolish mantain	maintain
Abolish maintenence	maintenance
Abolish mka{e,es,ing}	mak{}
Abolish amke	make
Abolish amkes	makes
Abolish makeing	making
Abolish malcom Malcolm
Abolish managment	management
Abolish marie Marie
Abolish marraige	marriage
Abolish massachusset{,t}s Massachusetts
Abolish mediteranean Mediterranean
Abolish memeber	member
Abolish merchent	merchant
Abolish mesage{,s}	message{}
Abolish michagan Michigan
Abolish missisip{,p}i Mississippi
Abolish mispell{,ing,ings,ed,s}	misspell{}
Abolish misouri Missouri
Abolish moeny	money
Abolish monserrat Montserrat
Abolish montnana Montana
Abolish mroe	more
Abolish omre	more
Abolish morgage	mortgage
Abolish mor{,r}isette Morissette
Abolish myu	my
Abolish mysefl	myself
Abolish mythraic Mithraic
Abolish naive	naïve
Abolish napoleonian Napoleonic
Abolish nazereth Nazareth
Abolish nec{ass,cess,es}ar{y,ily}	nec{ess}ar{}
Abolish {,un}nec{ce,ces,e}sar{y,ily}          {}nec{es}sar{}
Abolish nececsary necessary
Abolish neseccary necessary
Abolish negotiaing	negotiating
Abolish nver	never
Abolish foundland Newfoundland
Abolish newyorker New Yorker
Abolish nothign	nothing
Abolish llog NSLog(@"%|");
Abolish fformat [NSString stringWithFormat:@"%|"]
Abolish nw{o,e}	n{}w
Abolish nullabour Nullarbor
Abolish nuremburg Nuremberg
Abolish obediant	obedient
Abolish ocasion	occasion
Abolish occassion	occasion
Abolish oc{,c}ur{,ed,ence,rance}	oc{c}urr{,ed,ence,ence}
Abolish of{its,the}	of {}
Abolish one{of,point}	one {}
Abolish onyl	only
Abolish opne open
Abolish opperation	operation
Abolish oeprator	operator
Abolish opp{o,er}tunit{y,ies}	opp{or}tunit{}
Abolish opposible	opposable
Abolish oppasite	opposite
Abolish oppos{ate,it}	opposite
Abolish orginiz{e,ed,ation}	organiz{}
Abolish {,un}orgin{,al}                       {}origin{}
Abolish o{hte,teh}r	other
Abolish otu	out
Abolish outof	out of
Abolish overthe	over the
Abolish oxident	oxidant
Abolish palistian Palestinian
Abolish palistinian{,s} Palestinian{}
Abolish papaer	paper
Abolish parliment	parliament
Abolish partof	part of
Abolish paymetn	payment
Abolish paymetns	payments
Abolish peo{lpe,pel}	people
Abolish poeple	people
Abolish percentof	percent of
Abolish percentto	percent to
Abolish performence	performance
Abolish perh{asp,pas}	perhaps
Abolish perm{a,e,i}n{a,e,i}nt{,ly}	perm{a}n{e}nt{}
Abolish persistan{ce,t,tly}                   persisten{}
Abolish personalyl	personally
Abolish pciture	picture
Abolish peice{,s}	piece{}
Abolish pleasent	pleasant
Abolish postition	position
Abolish psoition{,ed,ally,s}	position{}
Abolish possable	possible
Abolish potentialy	potentially
Abolish pwoer	power
Abolish pregnent	pregnant
Abolish presance	presence
Abolish porblem{,s}	problem{}
Abolish probelm{,s}	problem{}
Abolish ptogress	progress
Abolish prominant{,ly}	prominent{}
Abolish prot{e,o}ge	protégé
Abolish porvide	provide
Abolish puting	putting
Abolish quater{,s,ly}	quarter{}
Abolish que{,s}{,t}{io,oi}{n,ns,ms,sn}	que{s}{t}{io}n{,s,s,s}
Abolish realize realise
Abolish realyl	really
Abolish rec{eie,ie}v{e,ed,ing}	rec{ei}v{}
Abolish recieve receive
Abolish reconize	recognize
Abolish re{c,cc}o{m,mm}end	recommend
Abolish reommend	recommend
Abolish recomend{,ation,ations,ed,s}	recommend{}
Abolish rec{co,com,o}mend{,s,ed,ing,ation}    rec{om}mend{}
Abolish recrod	record
Abolish reflektion reflection
Abolish referesh{,es}                         refresh{}
Abolish {,ir}releven{ce,cy,t,tly}             {}relevan{}
Abolish religous	religious
Abolish reluctent	reluctant
Abolish remeber	remember
Abolish REmove                                Remove
Abolish represnt	represent
Abolish represent{ativ,ive}s representatives
Abolish represetned	represented
Abolish reproducable                          reproducible
Abolish reserach	research
Abolish resollution	resolution
Abolish resouce{,s}                           resource{}
Abolish resorces	resources
Abolish respom{d,se}	respon{}
Abolish responce	response
Abolish respons{able,ibile,ability,iblity}	responsib{le,le,ility,ility}
Abolish rest{arau,uara}nt	restaurant
Abolish restraunt{,s}                         restaurant{}
Abolish reult	result
Abolish reveiw{,s,ed,ing}	review{}
Abolish reivew review
Abolish rythm	rhythm
Abolish rumers	rumors
Abolish said{he,it,that,the} said {}
Abolish smae	same
Abolish scedul{e,es,ed,ing,er}	schedul{}
Abolish shcool	school
Abolish seance	séance
Abolish seach search
Abolish secratary	secretary
Abolish sectino	section
Abolish sercurit security
Abolish segument{,s,ed,ation}                 segment{}
Abolish selectoin	selection
Abolish selectino selection
Abolish sefl self
Abolish sentance	sentence
Abolish seperat{e,es,ed,ing,ely,ion,ions,or}  separat{}
Abolish sep{are,er}ate	separate
Abolish seh	she
Abolish shesaid	she said
Abolish shineing	shining
Abolish shiped	shipped
Abolish shoudl	should
Abolish should{,e}nt shouldn’t
Abolish sohw	show
Abolish showinf	showing
Abolish signifacnt	significant
Abolish sim{al,ili}ar	 similar
Abolish simpyl	 simply
Abolish sincerly sincerely
Abolish snipet snippet
Abolish snippt snippet
Abolish soical	social
Abolish s{moe,oem,}	some
Abolish somet{hign,ing,hing,ting} something
Abolish somtimes	sometimes
Abolish somewaht	somewhat
Abolish soudn{,s}	sound{}
Abolish specificaly{,l}	specifically
Abolish speach	speech
Abolish stnad	stand
Abolish statment{,s}	statement{}
Abolish sitll	still
Abolish stpo	stop
Abolish sto{pry,yr}	story
Abolish stroy	story
Abolish strentgh	strength
Abolish strug{gel,le}	struggle
Abolish studnet	student
Abolish sucess	success
Abolish sucessfull	successful
Abolish successful{l,y,yl}	successful{,ly,ly}
Abolish sufficiant	sufficient
Abolish sup{o,pos}sed	  supposed
Abolish suppossed supposed
Abolish supris{e,ed,es,ing}	surpris{}
Abolish surprice surprise
Abolish swiming	swimming
Abolish tka{e,es,ing}	tak{}
Abolish talekd	talked
Abolish t{al,la}kign	talking
Abolish tecnical	technical
Abolish techincally technically
Abolish esting testing
Abolish TEsting Testing
Abolish textexpander TextExpander
Abolish textexpender TextExpander
Abolish tahn	than
Abolish thansk	thanks
Abolish ta{ht,th}	that
Abolish thatthe	that the
Abolish th{gat,ta}	that
Abolish tyhat	that
Abolish tha{ts,st}	that’s
Abolish the{new,same,two,government,first,company}	the {}
Abolish tj{,h}e	the
Abolish t{j,g}he	the
Abolish hte	the
Abolish t{the,eh,yhe}	the
Abolish teh{,n} the{}
Abolish th{eri,ier}	their
Abolish themself{,s}	themselves
Abolish htere	there
Abolish htese	these
Abolish {htey,tehy}	they
Abolish they{,ve}	they’{}
Abolish hting	thing
Abolish thnig{,s}	thing{}
Abolish thigsn	things
Abolish {htink,thikn}	think
Abolish htis	this
Abolish t{hsi,ihs,ghis}	this
Abolish thisyear	this year
Abolish thn{a,e}	th{}n
Abolish th{soe,ones}	those
Abolish threatend	threatened
Abolish timne	time
Abolish ot to
Abolish tothe	to the
Abolish todya	today
Abolish t{iogeth,ogeht}er	together
Abolish tomorow	tomorrow
Abolish ton{gih,ihg}t	tonight
Abolish torben Torben
Abolish totaly{,l}	totally
Abolish towrad	toward
Abolish traditionalyl	traditionally
Abolish transfered	transferred
Abolish tryed	tried
Abolish tru{el,le}y	truly
Abolish termoil	turmoil
Abolish tweetes tweets
Abolish ype                                   type
Abolish wself typeof(self) __weak weakSelf = self;
Abolish {t,y}po typo
Abolish typomore typo more
