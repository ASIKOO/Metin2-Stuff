-------------------------------------------------
-- �regasszony j�sl�s locale.lua �s questlib.lua
-- n�lk�l.
-- Magyaros�tva by P3NG3R
-------------------------------------------------
quest fortune_telling begin
    state start begin
		when oldwoman.chat."J�sl�s" begin
			local fortune_telling =
			{
			--  { prob	0	item	money	remove money
				{ 1,	0,	20,	20,	0	}, -- 10
				{ 499,	0,	10,	10,	0	}, -- 5
				{ 2500,	0,	5,	5,	0	}, -- 1
				{ 5000,	0,	0,	0,	0	},
				{ 1500,	0,	-5,	-5,	20000	},
				{ 499,	0,	-10,	-10,	20000	},
				{ 1,	0,	-20,	-20,	20000	},
			}
			local fortune_words =
			{
				{
					"A szerencse embere.",
					"...Ez nem l�tezik![ENTER]"..
					"Az aur�d.. arany sz�nben ragyog..[ENTER]"..
					"Ma nem tudsz rosszat tenni, ezt garant�lom![ENTER]"..
					"Olyan szerencs�d van ma mintha nem is ember lenn�l.[ENTER]"..
					"Ilyen alkalom biztos, hogy egy �letben[ENTER]"..
					"egyszer ad�dik![ENTER]"..
					"Haszn�ld ki![ENTER]"
				},
				{
					"Nagy szerencse",
					"Ilyet is ritk�n mondok, de ez a nap a ti�d.[ENTER]"..
					"Olyan karm�t �rzed az aur�don, hogy az eszm�letlen![ENTER]"..
					"Nem tudom elk�pzelni, hogy mi rossz t�rt�nhetne veled ma..[ENTER]"..
					"Szinte semmi![ENTER]"..
					"Ragadd meg az alkalmat �s most csin�lj dolgokat.[ENTER]"..
					"Ilyen nem sokszor van.[ENTER]"
				},
				{
					"Szerencse.",
					"Ma szerencs�d van..[ENTER]"..
					"Ilyenkor �rdemes a fontosabb teend�ket rendezni.[ENTER]"..
					"A szerencse m�land�, ezt ne feledd![ENTER]"
				},
				{
					"Se j�, se rossz.",
					"Ma neked se szerencs�d, se peched nincs.[ENTER]"..
					"Ilyen esetekben nem aj�nlatos komoly dolgokat[ENTER]"..
					"csin�lni, mert nem biztos, hogy siker�l.[ENTER]"..
					"A szerencse f�nye m�r l�that� az �gen, de nem neked sz�l.[ENTER]"
				},
				{
					"Pech.",
					"A mai nem a te napod..[ENTER]"..
					"Lehets�ges, hogy bel�d csap egy vill�m![ENTER]"..
					"L�gy �vatos �s ker�ld a bajt.[ENTER]"..
					"Hamarosan elm�lik a Pech...[ENTER]"
				},
				{
					"Nagy Pech.",
					"Ma nagyon szerencs�tlen napod van..[ENTER]"..
					"Szerintem ne kezdj bele semmi fontos dologba,[ENTER]"..
					"biztos kudarc az eredm�ny![ENTER]"..
					"H�zd meg magad a s�t�tben, am�g[ENTER]"..
					"elm�lik a felh� a fejed fel�l..![ENTER]"
				},
				{
					"A Pech embere.",
					"...Ajj-ajj, ezt ne..[ENTER]"..
					"Az aur�d a legs�t�tebb sz�nben pulz�l![ENTER]"..
					"Ez semmi j�t nem jelent![ENTER]"..
					"Ma iszonyatos pech-re sz�m�thatsz.[ENTER]"..
					"Vegy�l Kama var�zslat talizm�nt, tal�n azzal[ENTER]"..
					"cs�kken a pech-ed...[ENTER]"..
					"Ma szerintem ne menj sehov�,[ENTER]"..
					"mert csak baj lesz![ENTER]"
				},
			}
			if pc.get_level() < 20 then
				say_title(mob_name(9006)..":")
				say("Ez a j�sl�s igen csak f�raszt�, de egy olyannak")
				say("mint te nem tudok j�solni, hiszen m�g kicsi vagy.")
				say("�rd el a 20. Szintet �s gyere vissza hozz�m.")
			elseif get_time()-pc.getqf("time")<8*60*60 then
				local passed_time = get_time() - pc.getqf("time")
				say_title(mob_name(9006)..":")
				say("Neh�ny j�s n�, m�r az els� j�sl�s ut�n")
				say("bemondja az unalmast... �n nem!")
				say("")
				say("�n nap mint nap t�bb embernek is j�solok.")
				say("De egy embernek egy nap csak egyszer tudok.")
				say("Neked ma m�r j�soltam.. Szeretn�d megtudni mi")
				say("volt a j�slat?")
				wait()
				say_title(mob_name(9006)..":")
				say("")
				local idx = pc.getqf("idx")
				if idx!=0 then
					say_reward(string.format("A mai j�slatod: %s",fortune_words[idx][1]))
					say("")
					if pc.getqf("talisman") == 0 and fortune_telling[idx][5]>0 then
						local talisman_cost = fortune_telling[idx][5]
						wait()
						say_title(mob_name(9006)..":")
						say("Nekem van egy k�l�nleges talizm�nom,")
						say("amely haszn�lat�val megn�vekedik a szerencs�d")
						say("A Pech pedig cs�kken vele.")
						say("")
						say("A t�rgyak fejleszt�s�n�l is j�l j�het,")
						say("mert megn�velheti a jav�t�si es�lyt is.")
						say("")
						say_reward("Szeretn�l v�s�rolni a talizm�nb�l?")
						local s = select("Igen","Nem")
						if s == 1 then
							if pc.get_gold() < talisman_cost then
								say_title(mob_name(9006)..":")
								say("Nincs el�g Yangod a talizm�n megv�s�rl�s�hoz!")
								say(string.format("A Talizm�n �ra: %d Yang", talisman_cost))
								pc.setqf("talisman", 0)
							else
								pc.give_item2(70052,1)
								pc.changegold(-talisman_cost)
								pc.setqf("talisman", 1)
							end
						else
							return
						end
					end
				end
			else
				local gold = 7777
				say_title(mob_name(9006)..":")
				say("Szeretn�l j�soltatni?")
				say("Persze j�hoz fordult�l, �n tudok j�solni..")
				say("Mint mindennek, ennek is megvan a maga �ra.")
				say(string.format("A j�sl�s �ra: %d Yang.", gold))
				local s = select('J�soltatni', 'Cs�ves vagyok')
				if s == 1 then
					if pc.get_gold() < 7777 then
						say_title(mob_name(9006)..":")
						say("Nincs n�lad elegend� Yang a j�slathoz!")
					else
						n = number(1,10000)
						local i
						local idx
						for i = 1, table.getn(fortune_telling) do
							if n<=fortune_telling[i][1] then
								idx = i
								break
							else
								n = n - fortune_telling[i][1]
							end
						end
						i = idx
						say(fortune_words[i][2])
						local t = {}
						n = 0
						local j
						for j = 2,4 do
							if fortune_telling[i][j] != 0 then
								n=n+1
								t[n] = j
							end
						end
						if n>0 then
							n = number(1, n)
							__give_char_priv(t[n]-1, fortune_telling[i][t[n]])
						end
						pc.setqf("time", get_time())
						pc.setqf("idx", i)
						pc.change_gold(-gold)
						if fortune_telling[i][5]>0 then
							wait()
							say(fortune_words[i][3])
							say_reward("Akarsz v�s�rolni egy talizm�nt?")
							local talisman_cost = fortune_telling[i][5]
							local s = select("Igen","Nem")
							if s== 1 then
								if pc.get_gold() < talisman_cost then
									say_title(mob_name(9006)..":")
									say("Nincs el�g Yangod a talizm�n megv�s�rl�s�hoz!")
									say(string.format("A Talizm�n �ra: %d Yang", talisman_cost))
									pc.setqf("talisman", 0)
								else
									pc.give_item2(70052,1)
									pc.changegold(-talisman_cost)
									pc.setqf("talisman", 1)
								end
							elseif s == 2 then
								say_title(mob_name(9006)..":")
								say("H�t j�, de ne gyere panaszkodni, ha")
								say("nem lesz szerencs�d, mert �n seg�teni akartam!")
								pc.setqf("talisman", 0)
							end
						end
					end
				elseif s == 2 then
					say_title(mob_name(9006)..":")
					say("H�t ebben az esetben, gyere vissza ha")
					say("lesz el�g Yangod a j�slathoz.")
				end
			end
		end
    end
end

