// Credits to https://github.com/alexaubry/HTMLString

import Foundation

let HTMLSpecialMaxLength = 31

extension String {
    func unescapeAsNumber() -> String? {
        
        let isHexadecimal = hasPrefix("X") || hasPrefix("x")
        let radix = isHexadecimal ? 16 : 10
        
        let numberStartIndex = index(startIndex, offsetBy: isHexadecimal ? 1 : 0)
        let numberString = self[numberStartIndex ..< endIndex]
        
        guard let codePoint = UInt32(numberString, radix: radix),
            let scalar = UnicodeScalar(codePoint) else {
                return nil
        }
        
        return String(scalar)
    }
}

private final class BundleToken { }

func HTMLSpecial(for code: String) -> String? {
    if let res = popularHTMLSpecialsMap[code] {
        return res
    }
    
    if otherHTMLSpecialsMap == nil {
        do {
            let data = otherSpecials.data(using: .utf8)!
            otherHTMLSpecialsMap = try JSONDecoder().decode([String: String].self, from: data)
        }
        catch {
            fatalError(error.localizedDescription)
        }
    }
    
    return otherHTMLSpecialsMap?[code]
}

private let popularHTMLSpecialsMap: [String : String] = [
    "gt":"\u{3e}",
    "lt":"\u{3c}",
    "amp":"\u{26}"
]

private var otherHTMLSpecialsMap: [String : String]?

private let otherSpecials = "{\"nlt\":\"≮\",\"nless\":\"≮\",\"xdtri\":\"▽\",\"gtreqless\":\"⋛\",\"CHcy\":\"Ч\",\"caret\":\"⁁\",\"scap\":\"⪸\",\"ltrPar\":\"⦖\",\"straightepsilon\":\"ϵ\",\"twoheadrightarrow\":\"↠\",\"bsolhsub\":\"⟈\",\"boxUl\":\"╜\",\"ordf\":\"ª\",\"nvltrie\":\"⊴⃒\",\"image\":\"ℑ\",\"boxul\":\"┘\",\"iiint\":\"∭\",\"mid\":\"∣\",\"laemptyv\":\"⦴\",\"Kfr\":\"𝔎\",\"simeq\":\"≃\",\"gne\":\"⪈\",\"capcup\":\"⩇\",\"Rho\":\"Ρ\",\"Dcaron\":\"Ď\",\"Escr\":\"ℰ\",\"nparallel\":\"∦\",\"bigodot\":\"⨀\",\"khcy\":\"х\",\"shchcy\":\"щ\",\"cupbrcap\":\"⩈\",\"ccups\":\"⩌\",\"vzigzag\":\"⦚\",\"leftarrow\":\"←\",\"dHar\":\"⥥\",\"Gammad\":\"Ϝ\",\"notinvc\":\"⋶\",\"RightDownVector\":\"⇂\",\"prnsim\":\"⋨\",\"NotRightTriangleBar\":\"⧐̸\",\"thetasym\":\"ϑ\",\"HARDcy\":\"Ъ\",\"dotsquare\":\"⊡\",\"plusdo\":\"∔\",\"Uparrow\":\"⇑\",\"cwconint\":\"∲\",\"Because\":\"∵\",\"rotimes\":\"⨵\",\"sung\":\"♪\",\"micro\":\"µ\",\"CounterClockwiseContourIntegral\":\"∳\",\"ssmile\":\"⌣\",\"Yscr\":\"𝒴\",\"vsubnE\":\"⫋︀\",\"langle\":\"⟨\",\"Oslash\":\"Ø\",\"rmoustache\":\"⎱\",\"curlyeqprec\":\"⋞\",\"Iukcy\":\"І\",\"DownBreve\":\"̑\",\"Dfr\":\"𝔇\",\"atilde\":\"ã\",\"Zdot\":\"Ż\",\"llcorner\":\"⌞\",\"Acirc\":\"Â\",\"ensp\":\" \",\"Oopf\":\"𝕆\",\"REG\":\"®\",\"ordm\":\"º\",\"Verbar\":\"‖\",\"approxeq\":\"≊\",\"rightrightarrows\":\"⇉\",\"UpTee\":\"⊥\",\"mscr\":\"𝓂\",\"Supset\":\"⋑\",\"Mu\":\"Μ\",\"SHCHcy\":\"Щ\",\"Zeta\":\"Ζ\",\"lltri\":\"◺\",\"thorn\":\"þ\",\"ograve\":\"ò\",\"LeftUpVector\":\"↿\",\"Lcaron\":\"Ľ\",\"Cap\":\"⋒\",\"ldrdhar\":\"⥧\",\"ast\":\"*\",\"utdot\":\"⋰\",\"copf\":\"𝕔\",\"GreaterGreater\":\"⪢\",\"npr\":\"⊀\",\"CupCap\":\"≍\",\"lbrack\":\"[\",\"zfr\":\"𝔷\",\"ubreve\":\"ŭ\",\"vellip\":\"⋮\",\"Ccedil\":\"Ç\",\"upharpoonright\":\"↾\",\"Equilibrium\":\"⇌\",\"compfn\":\"∘\",\"hcirc\":\"ĥ\",\"rarrlp\":\"↬\",\"UnderBrace\":\"⏟\",\"scaron\":\"š\",\"subsetneq\":\"⊊\",\"uplus\":\"⊎\",\"empty\":\"∅\",\"boxUr\":\"╙\",\"minusb\":\"⊟\",\"notni\":\"∌\",\"OverBracket\":\"⎴\",\"sime\":\"≃\",\"GreaterEqualLess\":\"⋛\",\"hookleftarrow\":\"↩\",\"boxur\":\"└\",\"eacute\":\"é\",\"wopf\":\"𝕨\",\"ucirc\":\"û\",\"nGg\":\"⋙̸\",\"itilde\":\"ĩ\",\"excl\":\"!\",\"NotTildeEqual\":\"≄\",\"rbrksld\":\"⦎\",\"ulcorn\":\"⌜\",\"lozf\":\"⧫\",\"leftrightharpoons\":\"⇋\",\"gEl\":\"⪌\",\"bigtriangledown\":\"▽\",\"MinusPlus\":\"∓\",\"Sub\":\"⋐\",\"simg\":\"⪞\",\"HorizontalLine\":\"─\",\"Rang\":\"⟫\",\"sfr\":\"𝔰\",\"Larr\":\"↞\",\"sdotb\":\"⊡\",\"Jcy\":\"Й\",\"dagger\":\"†\",\"intercal\":\"⊺\",\"Lsh\":\"↰\",\"nLeftarrow\":\"⇍\",\"lmoustache\":\"⎰\",\"ominus\":\"⊖\",\"Lscr\":\"ℒ\",\"Tcaron\":\"Ť\",\"triangleright\":\"▹\",\"inodot\":\"ı\",\"gesl\":\"⋛︀\",\"scpolint\":\"⨓\",\"semi\":\";\",\"PrecedesSlantEqual\":\"≼\",\"llarr\":\"⇇\",\"nsupe\":\"⊉\",\"gsime\":\"⪎\",\"square\":\"□\",\"Bopf\":\"𝔹\",\"apos\":\"\'\",\"Kcedil\":\"Ķ\",\"awint\":\"⨑\",\"harrcir\":\"⥈\",\"frac56\":\"⅚\",\"ldca\":\"⤶\",\"xcup\":\"⋃\",\"nearr\":\"↗\",\"rharu\":\"⇀\",\"ltcc\":\"⪦\",\"lfr\":\"𝔩\",\"lnE\":\"≨\",\"minusd\":\"∸\",\"siml\":\"⪝\",\"napE\":\"⩰̸\",\"varnothing\":\"∅\",\"nGt\":\"≫⃒\",\"ropar\":\"⦆\",\"Sum\":\"∑\",\"NotSucceedsEqual\":\"⪰̸\",\"copysr\":\"℗\",\"eqslantless\":\"⪕\",\"bnequiv\":\"≡⃥\",\"DownLeftVectorBar\":\"⥖\",\"rcedil\":\"ŗ\",\"gesdot\":\"⪀\",\"LessLess\":\"⪡\",\"Vopf\":\"𝕍\",\"sdote\":\"⩦\",\"top\":\"⊤\",\"ntlg\":\"≸\",\"Sup\":\"⋑\",\"ccaps\":\"⩍\",\"squarf\":\"▪\",\"sqsub\":\"⊏\",\"tscr\":\"𝓉\",\"lvnE\":\"≨︀\",\"cupcup\":\"⩊\",\"nisd\":\"⋺\",\"efr\":\"𝔢\",\"Upsi\":\"ϒ\",\"bumpeq\":\"≏\",\"ENG\":\"Ŋ\",\"leftharpoonup\":\"↼\",\"cirscir\":\"⧂\",\"jopf\":\"𝕛\",\"Omicron\":\"Ο\",\"crarr\":\"↵\",\"bigtriangleup\":\"△\",\"Longleftarrow\":\"⟸\",\"alpha\":\"α\",\"shy\":\"­\",\"ycy\":\"ы\",\"capdot\":\"⩀\",\"Nacute\":\"Ń\",\"commat\":\"@\",\"SupersetEqual\":\"⊇\",\"yen\":\"¥\",\"reg\":\"®\",\"Scedil\":\"Ş\",\"nparsl\":\"⫽⃥\",\"frac58\":\"⅝\",\"Integral\":\"∫\",\"nVDash\":\"⊯\",\"GJcy\":\"Ѓ\",\"conint\":\"∮\",\"plusdu\":\"⨥\",\"hbar\":\"ℏ\",\"rpar\":\")\",\"asymp\":\"≈\",\"NotSquareSuperset\":\"⊐̸\",\"lparlt\":\"⦓\",\"uacute\":\"ú\",\"dtdot\":\"⋱\",\"DownRightTeeVector\":\"⥟\",\"InvisibleComma\":\"⁣\",\"Jcirc\":\"Ĵ\",\"LeftCeiling\":\"⌈\",\"centerdot\":\"·\",\"prec\":\"≺\",\"NotSubsetEqual\":\"⊈\",\"copy\":\"©\",\"cong\":\"≅\",\"ldquor\":\"„\",\"approx\":\"≈\",\"tscy\":\"ц\",\"rcy\":\"р\",\"Sigma\":\"Σ\",\"Wcirc\":\"Ŵ\",\"pertenk\":\"‱\",\"NotLeftTriangleEqual\":\"⋬\",\"Sqrt\":\"√\",\"doublebarwedge\":\"⌆\",\"ngeq\":\"≱\",\"nearhk\":\"⤤\",\"ultri\":\"◸\",\"Sscr\":\"𝒮\",\"rcub\":\"}\",\"mp\":\"∓\",\"rHar\":\"⥤\",\"dcaron\":\"ď\",\"Dstrok\":\"Đ\",\"ZeroWidthSpace\":\"​\",\"DiacriticalDoubleAcute\":\"˝\",\"sbquo\":\"‚\",\"gsiml\":\"⪐\",\"nges\":\"⩾̸\",\"Wfr\":\"𝔚\",\"loarr\":\"⇽\",\"mstpos\":\"∾\",\"gammad\":\"ϝ\",\"wedge\":\"∧\",\"mu\":\"μ\",\"Cross\":\"⨯\",\"Iopf\":\"𝕀\",\"Agrave\":\"À\",\"veeeq\":\"≚\",\"TRADE\":\"™\",\"plus\":\"+\",\"nharr\":\"↮\",\"block\":\"█\",\"kcy\":\"к\",\"boxDl\":\"╖\",\"gscr\":\"ℊ\",\"boxdl\":\"┐\",\"deg\":\"°\",\"langd\":\"⦑\",\"oslash\":\"ø\",\"nsce\":\"⪰̸\",\"planckh\":\"ℎ\",\"ocir\":\"⊚\",\"Gbreve\":\"Ğ\",\"dotplus\":\"∔\",\"trpezium\":\"⏢\",\"lozenge\":\"◊\",\"napid\":\"≋̸\",\"vsupne\":\"⊋︀\",\"ReverseEquilibrium\":\"⇋\",\"blk34\":\"▓\",\"Ecaron\":\"Ě\",\"Pfr\":\"𝔓\",\"longmapsto\":\"⟼\",\"lbrkslu\":\"⦍\",\"lne\":\"⪇\",\"vDash\":\"⊨\",\"lrtri\":\"⊿\",\"sqcups\":\"⊔︀\",\"subplus\":\"⪿\",\"nltrie\":\"⋬\",\"capcap\":\"⩋\",\"epsiv\":\"ϵ\",\"verbar\":\"|\",\"ReverseElement\":\"∋\",\"Superset\":\"⊃\",\"supset\":\"⊃\",\"Phi\":\"Φ\",\"leftharpoondown\":\"↽\",\"dcy\":\"д\",\"ltrie\":\"⊴\",\"Xi\":\"Ξ\",\"Euml\":\"Ë\",\"lmoust\":\"⎰\",\"Kappa\":\"Κ\",\"epar\":\"⋕\",\"nwnear\":\"⤧\",\"ell\":\"ℓ\",\"lcaron\":\"ľ\",\"qopf\":\"𝕢\",\"bowtie\":\"⋈\",\"Lstrok\":\"Ł\",\"triangleq\":\"≜\",\"subne\":\"⊊\",\"leftleftarrows\":\"⇇\",\"expectation\":\"ℰ\",\"laquo\":\"«\",\"ltrif\":\"◂\",\"iogon\":\"į\",\"nedot\":\"≐̸\",\"bsim\":\"∽\",\"Igrave\":\"Ì\",\"geqq\":\"≧\",\"mapstodown\":\"↧\",\"Lang\":\"⟪\",\"ccedil\":\"ç\",\"Ifr\":\"ℑ\",\"IEcy\":\"Е\",\"NotSquareSupersetEqual\":\"⋣\",\"topbot\":\"⌶\",\"UpperRightArrow\":\"↗\",\"NJcy\":\"Њ\",\"Yuml\":\"Ÿ\",\"topcir\":\"⫱\",\"larrfs\":\"⤝\",\"Vee\":\"⋁\",\"VeryThinSpace\":\" \",\"Fscr\":\"ℱ\",\"eng\":\"ŋ\",\"timesb\":\"⊠\",\"subseteqq\":\"⫅\",\"els\":\"⪕\",\"plusacir\":\"⨣\",\"ETH\":\"Ð\",\"curarr\":\"↷\",\"subsetneqq\":\"⫋\",\"xlArr\":\"⟸\",\"ffllig\":\"ﬄ\",\"PlusMinus\":\"±\",\"Gdot\":\"Ġ\",\"CloseCurlyDoubleQuote\":\"”\",\"curlyeqsucc\":\"⋟\",\"bottom\":\"⊥\",\"sqsubseteq\":\"⊑\",\"nsupset\":\"⊃⃒\",\"nsqsube\":\"⋢\",\"ShortUpArrow\":\"↑\",\"RightTriangleBar\":\"⧐\",\"nVdash\":\"⊮\",\"loplus\":\"⨭\",\"Bfr\":\"𝔅\",\"Zscr\":\"𝒵\",\"boxDr\":\"╓\",\"die\":\"¨\",\"nrarrw\":\"↝̸\",\"boxdr\":\"┌\",\"supedot\":\"⫄\",\"tcaron\":\"ť\",\"cularrp\":\"⤽\",\"isinE\":\"⋹\",\"cupdot\":\"⊍\",\"Hat\":\"^\",\"Tstrok\":\"Ŧ\",\"Vcy\":\"В\",\"lrarr\":\"⇆\",\"lEg\":\"⪋\",\"RightTeeArrow\":\"↦\",\"UnderBar\":\"_\",\"supsup\":\"⫖\",\"Popf\":\"ℙ\",\"naturals\":\"ℕ\",\"comp\":\"∁\",\"smid\":\"∣\",\"hercon\":\"⊹\",\"order\":\"ℴ\",\"nscr\":\"𝓃\",\"kcedil\":\"ķ\",\"tridot\":\"◬\",\"male\":\"♂\",\"urcorner\":\"⌝\",\"LessTilde\":\"≲\",\"ratail\":\"⤚\",\"odot\":\"⊙\",\"LeftUpDownVector\":\"⥑\",\"sqsup\":\"⊐\",\"supsetneqq\":\"⫌\",\"timesd\":\"⨰\",\"Scirc\":\"Ŝ\",\"xfr\":\"𝔵\",\"DoubleLeftTee\":\"⫤\",\"dopf\":\"𝕕\",\"nabla\":\"∇\",\"Uarrocir\":\"⥉\",\"Ocy\":\"О\",\"leftthreetimes\":\"⋋\",\"VerticalBar\":\"∣\",\"Longleftrightarrow\":\"⟺\",\"gimel\":\"ℷ\",\"circlearrowright\":\"↻\",\"hoarr\":\"⇿\",\"fallingdotseq\":\"≒\",\"NewLine\":\"\\n\",\"VerticalSeparator\":\"❘\",\"rarrhk\":\"↪\",\"Imacr\":\"Ī\",\"Lcedil\":\"Ļ\",\"lpar\":\"(\",\"parsl\":\"⫽\",\"lrm\":\"‎\",\"xopf\":\"𝕩\",\"Product\":\"∏\",\"LeftDownVectorBar\":\"⥙\",\"swnwar\":\"⤪\",\"Upsilon\":\"Υ\",\"NotSucceedsTilde\":\"≿̸\",\"period\":\".\",\"ldquo\":\"“\",\"blank\":\"␣\",\"KHcy\":\"Х\",\"qfr\":\"𝔮\",\"measuredangle\":\"∡\",\"div\":\"÷\",\"nacute\":\"ń\",\"angmsdaa\":\"⦨\",\"oelig\":\"œ\",\"isin\":\"∈\",\"scedil\":\"ş\",\"drcrop\":\"⌌\",\"Mscr\":\"ℳ\",\"lcub\":\"{\",\"shcy\":\"ш\",\"lHar\":\"⥢\",\"eta\":\"η\",\"twixt\":\"≬\",\"fltns\":\"▱\",\"apid\":\"≋\",\"nsupseteqq\":\"⫆̸\",\"backepsilon\":\"϶\",\"urtri\":\"◹\",\"cupcap\":\"⩆\",\"Copf\":\"ℂ\",\"jfr\":\"𝔧\",\"aring\":\"å\",\"par\":\"∥\",\"eqcirc\":\"≖\",\"tint\":\"∭\",\"Cedilla\":\"¸\",\"vBar\":\"⫨\",\"Oacute\":\"Ó\",\"Acy\":\"А\",\"ascr\":\"𝒶\",\"lsime\":\"⪍\",\"eogon\":\"ę\",\"Tcedil\":\"Ţ\",\"swarhk\":\"⤦\",\"diam\":\"⋄\",\"eth\":\"ð\",\"searr\":\"↘\",\"supdot\":\"⪾\",\"dstrok\":\"đ\",\"thksim\":\"∼\",\"uarr\":\"↑\",\"hslash\":\"ℏ\",\"Wopf\":\"𝕎\",\"nleftrightarrow\":\"↮\",\"utrif\":\"▴\",\"ApplyFunction\":\"⁡\",\"NotLeftTriangle\":\"⋪\",\"nleqq\":\"≦̸\",\"UpArrowBar\":\"⤒\",\"agrave\":\"à\",\"uscr\":\"𝓊\",\"xi\":\"ξ\",\"rtriltri\":\"⧎\",\"beta\":\"β\",\"cfr\":\"𝔠\",\"xnis\":\"⋻\",\"downdownarrows\":\"⇊\",\"malt\":\"✠\",\"blacklozenge\":\"⧫\",\"luruhar\":\"⥦\",\"strns\":\"¯\",\"frac12\":\"½\",\"lsimg\":\"⪏\",\"race\":\"∽̱\",\"plusmn\":\"±\",\"chi\":\"χ\",\"kopf\":\"𝕜\",\"uArr\":\"⇑\",\"gbreve\":\"ğ\",\"hellip\":\"…\",\"dsol\":\"⧶\",\"Udblac\":\"Ű\",\"colon\":\":\",\"delta\":\"δ\",\"SucceedsEqual\":\"⪰\",\"Hacek\":\"ˇ\",\"ecaron\":\"ě\",\"rsqb\":\"]\",\"NegativeThickSpace\":\"​\",\"infintie\":\"⧝\",\"ncap\":\"⩃\",\"marker\":\"▮\",\"mldr\":\"…\",\"Int\":\"∬\",\"GreaterTilde\":\"≳\",\"xmap\":\"⟼\",\"star\":\"☆\",\"times\":\"×\",\"dollar\":\"$\",\"plustwo\":\"⨧\",\"Jukcy\":\"Є\",\"spar\":\"∥\",\"Tab\":\"\\t\",\"frac13\":\"⅓\",\"suphsol\":\"⟉\",\"LessSlantEqual\":\"⩽\",\"ccupssm\":\"⩐\",\"TSHcy\":\"Ћ\",\"pcy\":\"п\",\"lstrok\":\"ł\",\"lhblk\":\"▄\",\"angle\":\"∠\",\"rsh\":\"↱\",\"napprox\":\"≉\",\"curlyvee\":\"⋎\",\"LeftUpTeeVector\":\"⥠\",\"igrave\":\"ì\",\"angmsdab\":\"⦩\",\"Ocirc\":\"Ô\",\"nvsim\":\"∼⃒\",\"Cup\":\"⋓\",\"dzigrarr\":\"⟿\",\"beth\":\"ℶ\",\"Exists\":\"∃\",\"larrbfs\":\"⤟\",\"sqsube\":\"⊑\",\"Tscr\":\"𝒯\",\"bigsqcup\":\"⨆\",\"sharp\":\"♯\",\"rfisht\":\"⥽\",\"nvinfin\":\"⧞\",\"frac14\":\"¼\",\"longleftrightarrow\":\"⟷\",\"Ufr\":\"𝔘\",\"SquareSubset\":\"⊏\",\"dot\":\"˙\",\"zhcy\":\"ж\",\"NotHumpEqual\":\"≏̸\",\"xrArr\":\"⟹\",\"rightleftharpoons\":\"⇌\",\"angmsd\":\"∡\",\"andand\":\"⩕\",\"varpropto\":\"∝\",\"ntgl\":\"≹\",\"nang\":\"∠⃒\",\"gtquest\":\"⩼\",\"larrlp\":\"↫\",\"checkmark\":\"✓\",\"planck\":\"ℏ\",\"COPY\":\"©\",\"divide\":\"÷\",\"icy\":\"и\",\"timesbar\":\"⨱\",\"Jopf\":\"𝕁\",\"fnof\":\"ƒ\",\"Leftarrow\":\"⇐\",\"harr\":\"↔\",\"icirc\":\"î\",\"mlcp\":\"⫛\",\"csube\":\"⫑\",\"Emacr\":\"Ē\",\"hscr\":\"𝒽\",\"rightharpoondown\":\"⇁\",\"solbar\":\"⌿\",\"mcomma\":\"⨩\",\"EmptyVerySmallSquare\":\"▫\",\"ntriangleleft\":\"⋪\",\"frac15\":\"⅕\",\"wreath\":\"≀\",\"backcong\":\"≌\",\"subsim\":\"⫇\",\"equiv\":\"≡\",\"larrsim\":\"⥳\",\"Nfr\":\"𝔑\",\"succeq\":\"⪰\",\"tstrok\":\"ŧ\",\"hArr\":\"⇔\",\"aleph\":\"ℵ\",\"rthree\":\"⋌\",\"iiiint\":\"⨌\",\"nvHarr\":\"⤄\",\"scnap\":\"⪺\",\"iprod\":\"⨼\",\"bcy\":\"б\",\"GT\":\">\",\"rtimes\":\"⋊\",\"Tau\":\"Τ\",\"Ncaron\":\"Ň\",\"therefore\":\"∴\",\"complement\":\"∁\",\"ovbar\":\"⌽\",\"mdash\":\"—\",\"prap\":\"⪷\",\"longrightarrow\":\"⟶\",\"downharpoonleft\":\"⇃\",\"Rightarrow\":\"⇒\",\"nesim\":\"≂̸\",\"nvlArr\":\"⤂\",\"ForAll\":\"∀\",\"NotTildeTilde\":\"≉\",\"rect\":\"▭\",\"comma\":\",\",\"ropf\":\"𝕣\",\"frac16\":\"⅙\",\"radic\":\"√\",\"pointint\":\"⨕\",\"subE\":\"⫅\",\"Map\":\"⤅\",\"cedil\":\"¸\",\"exponentiale\":\"ⅇ\",\"bigotimes\":\"⨂\",\"prurel\":\"⊰\",\"dtrif\":\"▾\",\"aogon\":\"ą\",\"DownLeftRightVector\":\"⥐\",\"Gfr\":\"𝔊\",\"oast\":\"⊛\",\"qprime\":\"⁗\",\"tbrk\":\"⎴\",\"varphi\":\"ϕ\",\"TildeFullEqual\":\"≅\",\"TScy\":\"Ц\",\"flat\":\"♭\",\"gamma\":\"γ\",\"NotCongruent\":\"≢\",\"gacute\":\"ǵ\",\"numsp\":\" \",\"DotDot\":\"⃜\",\"Gscr\":\"𝒢\",\"RBarr\":\"⤐\",\"uuarr\":\"⇈\",\"lcedil\":\"ļ\",\"Gg\":\"⋙\",\"equals\":\"=\",\"InvisibleTimes\":\"⁢\",\"boxtimes\":\"⊠\",\"NotEqualTilde\":\"≂̸\",\"curren\":\"¤\",\"Nu\":\"Ν\",\"NotGreaterSlantEqual\":\"⩾̸\",\"gneqq\":\"≩\",\"nshortparallel\":\"∦\",\"xvee\":\"⋁\",\"tritime\":\"⨻\",\"angmsdac\":\"⦪\",\"LessEqualGreater\":\"⋚\",\"DiacriticalGrave\":\"`\",\"DoubleDownArrow\":\"⇓\",\"gtcc\":\"⪧\",\"piv\":\"ϖ\",\"prsim\":\"≾\",\"rationals\":\"ℚ\",\"eqvparsl\":\"⧥\",\"lBarr\":\"⤎\",\"RightArrowBar\":\"⇥\",\"Tcy\":\"Т\",\"natur\":\"♮\",\"mumap\":\"⊸\",\"nexists\":\"∄\",\"Theta\":\"Θ\",\"straightphi\":\"ϕ\",\"simdot\":\"⩪\",\"frac18\":\"⅛\",\"Gt\":\"≫\",\"nprcue\":\"⋠\",\"profsurf\":\"⌓\",\"larrb\":\"⇤\",\"Qopf\":\"ℚ\",\"searrow\":\"↘\",\"backsim\":\"∽\",\"oscr\":\"ℴ\",\"gvnE\":\"≩︀\",\"oacute\":\"ó\",\"real\":\"ℜ\",\"incare\":\"℅\",\"boxHD\":\"╦\",\"AElig\":\"Æ\",\"vfr\":\"𝔳\",\"ThickSpace\":\"  \",\"oline\":\"‾\",\"boxhD\":\"╥\",\"NotLessTilde\":\"≴\",\"tcedil\":\"ţ\",\"ncong\":\"≇\",\"Mcy\":\"М\",\"DiacriticalAcute\":\"´\",\"uhblk\":\"▀\",\"eopf\":\"𝕖\",\"udarr\":\"⇅\",\"lsqb\":\"[\",\"lagran\":\"ℒ\",\"sqcap\":\"⊓\",\"lesges\":\"⪓\",\"vltri\":\"⊲\",\"sqcaps\":\"⊓︀\",\"eplus\":\"⩱\",\"NotGreaterEqual\":\"≱\",\"NotTilde\":\"≁\",\"ngE\":\"≧̸\",\"cirmid\":\"⫯\",\"profline\":\"⌒\",\"hamilt\":\"ℋ\",\"Amacr\":\"Ā\",\"cirE\":\"⧃\",\"ecirc\":\"ê\",\"yopf\":\"𝕪\",\"DownArrowBar\":\"⤓\",\"ofr\":\"𝔬\",\"notinE\":\"⋹̸\",\"gescc\":\"⪩\",\"emptyset\":\"∅\",\"lesssim\":\"≲\",\"robrk\":\"⟧\",\"udblac\":\"ű\",\"parallel\":\"∥\",\"Fcy\":\"Ф\",\"profalar\":\"⌮\",\"RightFloor\":\"⌋\",\"asympeq\":\"≍\",\"ntriangleright\":\"⋫\",\"bsemi\":\"⁏\",\"HumpEqual\":\"≏\",\"rAarr\":\"⇛\",\"leftarrowtail\":\"↢\",\"auml\":\"ä\",\"iexcl\":\"¡\",\"nleq\":\"≰\",\"NotVerticalBar\":\"∤\",\"veebar\":\"⊻\",\"orslope\":\"⩗\",\"Abreve\":\"Ă\",\"yucy\":\"ю\",\"Backslash\":\"∖\",\"UpEquilibrium\":\"⥮\",\"frac45\":\"⅘\",\"Nscr\":\"𝒩\",\"succapprox\":\"⪸\",\"ohm\":\"Ω\",\"nap\":\"≉\",\"gE\":\"≧\",\"dwangle\":\"⦦\",\"yicy\":\"ї\",\"Dashv\":\"⫤\",\"hfr\":\"𝔥\",\"rightsquigarrow\":\"↝\",\"nles\":\"⩽̸\",\"RuleDelayed\":\"⧴\",\"pound\":\"£\",\"supseteq\":\"⊇\",\"yacy\":\"я\",\"gtrarr\":\"⥸\",\"blk12\":\"▒\",\"uuml\":\"ü\",\"Dopf\":\"𝔻\",\"SquareSubsetEqual\":\"⊑\",\"vdash\":\"⊢\",\"bscr\":\"𝒷\",\"umacr\":\"ū\",\"LeftUpVectorBar\":\"⥘\",\"LeftRightArrow\":\"↔\",\"angmsdad\":\"⦫\",\"bprime\":\"‵\",\"succ\":\"≻\",\"ohbar\":\"⦵\",\"duarr\":\"⇵\",\"tilde\":\"˜\",\"NoBreak\":\"⁠\",\"cdot\":\"ċ\",\"dtri\":\"▿\",\"gap\":\"⪆\",\"varr\":\"↕\",\"horbar\":\"―\",\"NotPrecedesEqual\":\"⪯̸\",\"Xopf\":\"𝕏\",\"vprop\":\"∝\",\"afr\":\"𝔞\",\"nbsp\":\" \",\"vscr\":\"𝓋\",\"blk14\":\"░\",\"ntrianglerighteq\":\"⋭\",\"triminus\":\"⨺\",\"angsph\":\"∢\",\"cuwed\":\"⋏\",\"dlcrop\":\"⌍\",\"vert\":\"|\",\"LeftArrowRightArrow\":\"⇆\",\"NotSucceedsSlantEqual\":\"⋡\",\"ucy\":\"у\",\"ne\":\"≠\",\"neArr\":\"⇗\",\"Vbar\":\"⫫\",\"nwarr\":\"↖\",\"DownTeeArrow\":\"↧\",\"disin\":\"⋲\",\"circledcirc\":\"⊚\",\"lopf\":\"𝕝\",\"vArr\":\"⇕\",\"ShortLeftArrow\":\"←\",\"bsolb\":\"⧅\",\"urcrop\":\"⌎\",\"ni\":\"∋\",\"PartialD\":\"∂\",\"scnE\":\"⪶\",\"DownLeftTeeVector\":\"⥞\",\"odiv\":\"⨸\",\"CircleTimes\":\"⊗\",\"barwedge\":\"⌅\",\"Prime\":\"″\",\"nldr\":\"‥\",\"Ubrcy\":\"Ў\",\"Zfr\":\"ℨ\",\"ge\":\"≥\",\"NotGreater\":\"≯\",\"blacktriangleright\":\"▸\",\"lbbrk\":\"❲\",\"imath\":\"ı\",\"NotNestedLessLess\":\"⪡̸\",\"gg\":\"≫\",\"xotime\":\"⨂\",\"ncaron\":\"ň\",\"bigwedge\":\"⋀\",\"LowerRightArrow\":\"↘\",\"ncy\":\"н\",\"Ascr\":\"𝒜\",\"NotPrecedesSlantEqual\":\"⋠\",\"midcir\":\"⫰\",\"nu\":\"ν\",\"biguplus\":\"⨄\",\"nsubset\":\"⊂⃒\",\"rpargt\":\"⦔\",\"starf\":\"★\",\"psi\":\"ψ\",\"gl\":\"≷\",\"apE\":\"⩰\",\"Colone\":\"⩴\",\"ddarr\":\"⇊\",\"SHcy\":\"Ш\",\"nge\":\"≱\",\"precneqq\":\"⪵\",\"NestedGreaterGreater\":\"≫\",\"Gcirc\":\"Ĝ\",\"Uarr\":\"↟\",\"para\":\"¶\",\"NotLeftTriangleBar\":\"⧏̸\",\"latail\":\"⤙\",\"OpenCurlyQuote\":\"‘\",\"Sfr\":\"𝔖\",\"rarrap\":\"⥵\",\"bot\":\"⊥\",\"SquareSuperset\":\"⊐\",\"Uscr\":\"𝒰\",\"target\":\"⌖\",\"sube\":\"⊆\",\"gel\":\"⋛\",\"CloseCurlyQuote\":\"’\",\"Beta\":\"Β\",\"DD\":\"ⅅ\",\"gcy\":\"г\",\"iukcy\":\"і\",\"bkarow\":\"⤍\",\"prcue\":\"≼\",\"Rarrtl\":\"⤖\",\"NotEqual\":\"≠\",\"grave\":\"`\",\"DifferentialD\":\"ⅆ\",\"olt\":\"⧀\",\"Aacute\":\"Á\",\"diamond\":\"⋄\",\"acirc\":\"â\",\"divideontimes\":\"⋇\",\"Kopf\":\"𝕂\",\"eqsim\":\"≂\",\"nmid\":\"∤\",\"primes\":\"ℙ\",\"larrhk\":\"↩\",\"iscr\":\"𝒾\",\"geq\":\"≥\",\"ggg\":\"⋙\",\"egsdot\":\"⪘\",\"ges\":\"⩾\",\"Lfr\":\"𝔏\",\"supplus\":\"⫀\",\"half\":\"½\",\"scE\":\"⪴\",\"angmsdae\":\"⦬\",\"Star\":\"⋆\",\"nesear\":\"⤨\",\"Re\":\"ℜ\",\"EqualTilde\":\"≂\",\"simgE\":\"⪠\",\"vartheta\":\"ϑ\",\"simrarr\":\"⥲\",\"UpArrowDownArrow\":\"⇅\",\"realine\":\"ℛ\",\"xharr\":\"⟷\",\"demptyv\":\"⦱\",\"fork\":\"⋔\",\"ngt\":\"≯\",\"rsquor\":\"’\",\"elinters\":\"⏧\",\"doteqdot\":\"≑\",\"NotLessLess\":\"≪̸\",\"xwedge\":\"⋀\",\"nhArr\":\"⇎\",\"nsimeq\":\"≄\",\"Uring\":\"Ů\",\"Precedes\":\"≺\",\"Coproduct\":\"∐\",\"wedgeq\":\"≙\",\"subsub\":\"⫕\",\"sect\":\"§\",\"ngeqslant\":\"⩾̸\",\"leqslant\":\"⩽\",\"and\":\"∧\",\"sopf\":\"𝕤\",\"sqsupseteq\":\"⊒\",\"Efr\":\"𝔈\",\"dzcy\":\"џ\",\"smashp\":\"⨳\",\"DownLeftVector\":\"↽\",\"vrtri\":\"⊳\",\"nsucceq\":\"⪰̸\",\"Iacute\":\"Í\",\"Breve\":\"˘\",\"iquest\":\"¿\",\"ang\":\"∠\",\"Ycy\":\"Ы\",\"djcy\":\"ђ\",\"rlarr\":\"⇄\",\"iocy\":\"ё\",\"Ncedil\":\"Ņ\",\"rdsh\":\"↳\",\"rAtail\":\"⤜\",\"nRightarrow\":\"⇏\",\"UnderParenthesis\":\"⏝\",\"nsupseteq\":\"⊉\",\"boxHU\":\"╩\",\"Hscr\":\"ℋ\",\"succneqq\":\"⪶\",\"RoundImplies\":\"⥰\",\"subseteq\":\"⊆\",\"ord\":\"⩝\",\"boxhU\":\"╨\",\"circ\":\"ˆ\",\"nis\":\"⋼\",\"nexist\":\"∄\",\"ZHcy\":\"Ж\",\"supnE\":\"⫌\",\"cudarrl\":\"⤸\",\"circlearrowleft\":\"↺\",\"Idot\":\"İ\",\"raemptyv\":\"⦳\",\"boxplus\":\"⊞\",\"imagline\":\"ℐ\",\"niv\":\"∋\",\"ouml\":\"ö\",\"oint\":\"∮\",\"coloneq\":\"≔\",\"perp\":\"⊥\",\"cire\":\"≗\",\"dfisht\":\"⥿\",\"Rcy\":\"Р\",\"triplus\":\"⨹\",\"RightTee\":\"⊢\",\"lsquo\":\"‘\",\"NotRightTriangleEqual\":\"⋭\",\"RightUpVector\":\"↾\",\"gtrapprox\":\"⪆\",\"varsupsetneq\":\"⊋︀\",\"ape\":\"≊\",\"Epsilon\":\"Ε\",\"LeftArrowBar\":\"⇤\",\"lneqq\":\"≨\",\"abreve\":\"ă\",\"Odblac\":\"Ő\",\"gtrsim\":\"≳\",\"forall\":\"∀\",\"uparrow\":\"↑\",\"imof\":\"⊷\",\"uml\":\"¨\",\"fflig\":\"ﬀ\",\"tosa\":\"⤩\",\"ngeqq\":\"≧̸\",\"because\":\"∵\",\"SquareIntersection\":\"⊓\",\"backprime\":\"‵\",\"Ropf\":\"ℝ\",\"spades\":\"♠\",\"vsubne\":\"⊊︀\",\"THORN\":\"Þ\",\"CapitalDifferentialD\":\"ⅅ\",\"Utilde\":\"Ũ\",\"pscr\":\"𝓅\",\"OverBar\":\"‾\",\"tfr\":\"𝔱\",\"part\":\"∂\",\"frac78\":\"⅞\",\"Kcy\":\"К\",\"Ccirc\":\"Ĉ\",\"rtri\":\"▹\",\"Jsercy\":\"Ј\",\"thetav\":\"ϑ\",\"angmsdaf\":\"⦭\",\"gesdotol\":\"⪄\",\"SucceedsTilde\":\"≿\",\"fopf\":\"𝕗\",\"seswar\":\"⤩\",\"preceq\":\"⪯\",\"GreaterSlantEqual\":\"⩾\",\"lrcorner\":\"⌟\",\"angst\":\"Å\",\"nltri\":\"⋪\",\"lgE\":\"⪑\",\"ImaginaryI\":\"ⅈ\",\"napos\":\"ŉ\",\"iiota\":\"℩\",\"hksearow\":\"⤥\",\"orv\":\"⩛\",\"sce\":\"⪰\",\"lfisht\":\"⥼\",\"cuesc\":\"⋟\",\"ReverseUpEquilibrium\":\"⥯\",\"cuvee\":\"⋎\",\"epsi\":\"ε\",\"Del\":\"∇\",\"RightVectorBar\":\"⥓\",\"LeftTriangle\":\"⊲\",\"mfr\":\"𝔪\",\"ltlarr\":\"⥶\",\"npar\":\"∦\",\"backsimeq\":\"⋍\",\"Subset\":\"⋐\",\"NotSuperset\":\"⊃⃒\",\"zopf\":\"𝕫\",\"Dcy\":\"Д\",\"digamma\":\"ϝ\",\"boxH\":\"═\",\"curvearrowright\":\"↷\",\"triangleleft\":\"◃\",\"szlig\":\"ß\",\"NotCupCap\":\"≭\",\"jcirc\":\"ĵ\",\"Yacute\":\"Ý\",\"nsub\":\"⊄\",\"lescc\":\"⪨\",\"roarr\":\"⇾\",\"kjcy\":\"ќ\",\"isins\":\"⋴\",\"sigma\":\"σ\",\"lap\":\"⪅\",\"lvertneqq\":\"≨︀\",\"wcirc\":\"ŵ\",\"Oscr\":\"𝒪\",\"DoubleContourIntegral\":\"∯\",\"ffr\":\"𝔣\",\"lthree\":\"⋋\",\"mho\":\"℧\",\"rangd\":\"⦒\",\"LeftDownTeeVector\":\"⥡\",\"colone\":\"≔\",\"pluscir\":\"⨢\",\"Leftrightarrow\":\"⇔\",\"lat\":\"⪫\",\"zcy\":\"з\",\"ltimes\":\"⋉\",\"ShortDownArrow\":\"↓\",\"Eopf\":\"𝔼\",\"Lmidot\":\"Ŀ\",\"LowerLeftArrow\":\"↙\",\"ddotseq\":\"⩷\",\"ndash\":\"–\",\"cross\":\"✗\",\"submult\":\"⫁\",\"range\":\"⦥\",\"cscr\":\"𝒸\",\"bump\":\"≎\",\"Uogon\":\"Ų\",\"csupe\":\"⫒\",\"between\":\"≬\",\"numero\":\"№\",\"awconint\":\"∳\",\"filig\":\"ﬁ\",\"minus\":\"−\",\"nlarr\":\"↚\",\"isinv\":\"∈\",\"rtrie\":\"⊵\",\"brvbar\":\"¦\",\"not\":\"¬\",\"hybull\":\"⁃\",\"rarrtl\":\"↣\",\"Yopf\":\"𝕐\",\"cwint\":\"∱\",\"rightharpoonup\":\"⇀\",\"DiacriticalDot\":\"˙\",\"xuplus\":\"⨄\",\"intprod\":\"⨼\",\"aacute\":\"á\",\"wscr\":\"𝓌\",\"scy\":\"с\",\"RightAngleBracket\":\"⟩\",\"SquareSupersetEqual\":\"⊒\",\"macr\":\"¯\",\"rbrkslu\":\"⦐\",\"raquo\":\"»\",\"rtrif\":\"▸\",\"leg\":\"⋚\",\"loang\":\"⟬\",\"bigcup\":\"⋃\",\"Auml\":\"Ä\",\"phone\":\"☎\",\"LessFullEqual\":\"≦\",\"DoubleUpArrow\":\"⇑\",\"NotGreaterGreater\":\"≫̸\",\"nsc\":\"⊁\",\"mopf\":\"𝕞\",\"amalg\":\"⨿\",\"bull\":\"•\",\"dotminus\":\"∸\",\"kappa\":\"κ\",\"angmsdag\":\"⦮\",\"rx\":\"℞\",\"phiv\":\"ϕ\",\"seArr\":\"⇘\",\"dd\":\"ⅆ\",\"Omega\":\"Ω\",\"Xfr\":\"𝔛\",\"lesdotor\":\"⪃\",\"LeftAngleBracket\":\"⟨\",\"swarr\":\"↙\",\"smeparsl\":\"⧤\",\"otimesas\":\"⨶\",\"ntrianglelefteq\":\"⋬\",\"bepsi\":\"϶\",\"UnderBracket\":\"⎵\",\"lcy\":\"л\",\"Uuml\":\"Ü\",\"ldsh\":\"↲\",\"congdot\":\"⩭\",\"omicron\":\"ο\",\"Therefore\":\"∴\",\"notindot\":\"⋵̸\",\"harrw\":\"↭\",\"boxV\":\"║\",\"erarr\":\"⥱\",\"nbump\":\"≎̸\",\"Bscr\":\"ℬ\",\"nspar\":\"∦\",\"SubsetEqual\":\"⊆\",\"Gcedil\":\"Ģ\",\"lbarr\":\"⤌\",\"YUcy\":\"Ю\",\"angzarr\":\"⍼\",\"leq\":\"≤\",\"lneq\":\"⪇\",\"nshortmid\":\"∤\",\"complexes\":\"ℂ\",\"nsup\":\"⊅\",\"DownArrow\":\"↓\",\"questeq\":\"≟\",\"Cdot\":\"Ċ\",\"YIcy\":\"Ї\",\"rrarr\":\"⇉\",\"lhard\":\"↽\",\"iacute\":\"í\",\"bcong\":\"≌\",\"les\":\"⩽\",\"Qfr\":\"𝔔\",\"iuml\":\"ï\",\"YAcy\":\"Я\",\"CirclePlus\":\"⊕\",\"LeftVector\":\"↼\",\"PrecedesEqual\":\"⪯\",\"ncedil\":\"ņ\",\"Lleftarrow\":\"⇚\",\"ncup\":\"⩂\",\"FilledSmallSquare\":\"◼\",\"rharul\":\"⥬\",\"Barv\":\"⫧\",\"boxHd\":\"╤\",\"Vscr\":\"𝒱\",\"RightVector\":\"⇀\",\"solb\":\"⧄\",\"nequiv\":\"≢\",\"ecy\":\"э\",\"NotReverseElement\":\"∌\",\"uHar\":\"⥣\",\"Vert\":\"‖\",\"ulcrop\":\"⌏\",\"boxhd\":\"┬\",\"DoubleLeftRightArrow\":\"⇔\",\"ofcir\":\"⦿\",\"lrhar\":\"⇋\",\"GreaterFullEqual\":\"≧\",\"rightleftarrows\":\"⇄\",\"OElig\":\"Œ\",\"lceil\":\"⌈\",\"lbrke\":\"⦋\",\"lnapprox\":\"⪉\",\"nvle\":\"≤⃒\",\"tshcy\":\"ћ\",\"pitchfork\":\"⋔\",\"Eta\":\"Η\",\"Ycirc\":\"Ŷ\",\"Lopf\":\"𝕃\",\"female\":\"♀\",\"NotRightTriangle\":\"⋫\",\"ijlig\":\"ĳ\",\"omid\":\"⦶\",\"HumpDownHump\":\"≎\",\"jscr\":\"𝒿\",\"Jfr\":\"𝔍\",\"setminus\":\"∖\",\"dblac\":\"˝\",\"odsold\":\"⦼\",\"sim\":\"∼\",\"trie\":\"≜\",\"zwnj\":\"‌\",\"DoubleLongRightArrow\":\"⟹\",\"Ntilde\":\"Ñ\",\"eqcolon\":\"≕\",\"fllig\":\"ﬂ\",\"odblac\":\"ő\",\"nsubE\":\"⫅̸\",\"ltri\":\"◃\",\"cups\":\"∪︀\",\"thkap\":\"≈\",\"nwarhk\":\"⤣\",\"Omacr\":\"Ō\",\"num\":\"#\",\"Intersection\":\"⋂\",\"scirc\":\"ŝ\",\"TildeEqual\":\"≃\",\"rfloor\":\"⌋\",\"rdquo\":\"”\",\"thickapprox\":\"≈\",\"RightDownVectorBar\":\"⥕\",\"caps\":\"∩︀\",\"utilde\":\"ũ\",\"bumpE\":\"⪮\",\"minusdu\":\"⨪\",\"NotExists\":\"∄\",\"bbrk\":\"⎵\",\"Cfr\":\"ℭ\",\"Or\":\"⩔\",\"bernou\":\"ℬ\",\"topf\":\"𝕥\",\"imacr\":\"ī\",\"jsercy\":\"ј\",\"dash\":\"‐\",\"Chi\":\"Χ\",\"nrtri\":\"⋫\",\"percnt\":\"%\",\"DownTee\":\"⊤\",\"capand\":\"⩄\",\"egs\":\"⪖\",\"esim\":\"≂\",\"drbkarow\":\"⤐\",\"angmsdah\":\"⦯\",\"NotSucceeds\":\"⊁\",\"Lambda\":\"Λ\",\"MediumSpace\":\" \",\"realpart\":\"ℜ\",\"SmallCircle\":\"∘\",\"ngtr\":\"≯\",\"Racute\":\"Ŕ\",\"gtreqqless\":\"⪌\",\"Iscr\":\"ℐ\",\"emsp13\":\" \",\"subset\":\"⊂\",\"sigmaf\":\"ς\",\"downarrow\":\"↓\",\"yfr\":\"𝔶\",\"boxVH\":\"╬\",\"Pcy\":\"П\",\"nLl\":\"⋘̸\",\"boxvH\":\"╪\",\"lotimes\":\"⨴\",\"yacute\":\"ý\",\"frasl\":\"⁄\",\"divonx\":\"⋇\",\"Rsh\":\"↱\",\"mapsto\":\"↦\",\"lesdoto\":\"⪁\",\"angrt\":\"∟\",\"Proportional\":\"∝\",\"Poincareplane\":\"ℌ\",\"kgreen\":\"ĸ\",\"bullet\":\"•\",\"NotLessSlantEqual\":\"⩽̸\",\"Laplacetrf\":\"ℒ\",\"boxh\":\"─\",\"Cayleys\":\"ℭ\",\"emsp14\":\" \",\"swarrow\":\"↙\",\"ShortRightArrow\":\"→\",\"SucceedsSlantEqual\":\"≽\",\"ecir\":\"≖\",\"maltese\":\"✠\",\"Dot\":\"¨\",\"Sopf\":\"𝕊\",\"ldrushar\":\"⥋\",\"rfr\":\"𝔯\",\"nvlt\":\"<⃒\",\"UpArrow\":\"↑\",\"qscr\":\"𝓆\",\"Hstrok\":\"Ħ\",\"lmidot\":\"ŀ\",\"nLt\":\"≪⃒\",\"Icy\":\"И\",\"jmath\":\"ȷ\",\"nGtv\":\"≫̸\",\"cudarrr\":\"⤵\",\"topfork\":\"⫚\",\"phmmat\":\"ℳ\",\"LeftRightVector\":\"⥎\",\"NotNestedGreaterGreater\":\"⪢̸\",\"Zacute\":\"Ź\",\"nrarr\":\"↛\",\"gtcir\":\"⩺\",\"Egrave\":\"È\",\"ecolon\":\"≕\",\"smt\":\"⪪\",\"gopf\":\"𝕘\",\"trianglelefteq\":\"⊴\",\"DZcy\":\"Џ\",\"Hcirc\":\"Ĥ\",\"rhov\":\"ϱ\",\"boxVL\":\"╣\",\"blacktriangleleft\":\"◂\",\"kfr\":\"𝔨\",\"boxvL\":\"╡\",\"sol\":\"\\/\",\"subsup\":\"⫓\",\"rho\":\"ρ\",\"cularr\":\"↶\",\"DJcy\":\"Ђ\",\"Bcy\":\"Б\",\"Ouml\":\"Ö\",\"Ucirc\":\"Û\",\"gesles\":\"⪔\",\"isindot\":\"⋵\",\"IOcy\":\"Ё\",\"opar\":\"⦷\",\"blacktriangledown\":\"▾\",\"mDDot\":\"∺\",\"OverParenthesis\":\"⏜\",\"infin\":\"∞\",\"jukcy\":\"є\",\"ufisht\":\"⥾\",\"lbrksld\":\"⦏\",\"oS\":\"Ⓢ\",\"frac34\":\"¾\",\"suplarr\":\"⥻\",\"clubsuit\":\"♣\",\"supsetneq\":\"⊋\",\"lsim\":\"≲\",\"lowbar\":\"_\",\"oplus\":\"⊕\",\"ljcy\":\"љ\",\"precnsim\":\"⋨\",\"dfr\":\"𝔡\",\"cent\":\"¢\",\"npreceq\":\"⪯̸\",\"circleddash\":\"⊝\",\"vBarv\":\"⫩\",\"upsilon\":\"υ\",\"OpenCurlyDoubleQuote\":\"“\",\"rarrbfs\":\"⤠\",\"ocirc\":\"ô\",\"Pscr\":\"𝒫\",\"nearrow\":\"↗\",\"frac35\":\"⅗\",\"sqsubset\":\"⊏\",\"rppolint\":\"⨒\",\"softcy\":\"ь\",\"lsquor\":\"‚\",\"darr\":\"↓\",\"Fopf\":\"𝔽\",\"DoubleVerticalBar\":\"∥\",\"oror\":\"⩖\",\"emacr\":\"ē\",\"bigcap\":\"⋂\",\"NestedLessLess\":\"≪\",\"Bernoullis\":\"ℬ\",\"bigoplus\":\"⨁\",\"dscr\":\"𝒹\",\"vsupnE\":\"⫌︀\",\"cap\":\"∩\",\"boxv\":\"│\",\"plusb\":\"⊞\",\"olcir\":\"⦾\",\"nsucc\":\"⊁\",\"trade\":\"™\",\"vangrt\":\"⦜\",\"easter\":\"⩮\",\"edot\":\"ė\",\"frown\":\"⌢\",\"angrtvbd\":\"⦝\",\"Cacute\":\"Ć\",\"nsubseteq\":\"⊈\",\"lrhard\":\"⥭\",\"rarrsim\":\"⥴\",\"Zopf\":\"ℤ\",\"dArr\":\"⇓\",\"alefsym\":\"ℵ\",\"Implies\":\"⇒\",\"lharu\":\"↼\",\"nprec\":\"⊀\",\"slarr\":\"←\",\"lAtail\":\"⤛\",\"xscr\":\"𝓍\",\"or\":\"∨\",\"squ\":\"□\",\"nsime\":\"≄\",\"tprime\":\"‴\",\"prnE\":\"⪵\",\"subrarr\":\"⥹\",\"succsim\":\"≿\",\"lopar\":\"⦅\",\"RightTeeVector\":\"⥛\",\"boxVR\":\"╠\",\"rlm\":\"‏\",\"SuchThat\":\"∋\",\"boxvR\":\"╞\",\"loz\":\"◊\",\"imped\":\"Ƶ\",\"boxHu\":\"╧\",\"lnap\":\"⪉\",\"eDot\":\"≑\",\"drcorn\":\"⌟\",\"shortparallel\":\"∥\",\"hkswarow\":\"⤦\",\"ac\":\"∾\",\"ntilde\":\"ñ\",\"nhpar\":\"⫲\",\"Ugrave\":\"Ù\",\"nopf\":\"𝕟\",\"SOFTcy\":\"Ь\",\"Vfr\":\"𝔙\",\"boxhu\":\"┴\",\"Alpha\":\"Α\",\"sub\":\"⊂\",\"RightUpDownVector\":\"⥏\",\"vartriangleright\":\"⊳\",\"supne\":\"⊋\",\"af\":\"⁡\",\"daleth\":\"ℸ\",\"smtes\":\"⪬︀\",\"pluse\":\"⩲\",\"subdot\":\"⪽\",\"jcy\":\"й\",\"nvrtrie\":\"⊵⃒\",\"uharl\":\"↿\",\"lsh\":\"↰\",\"dscy\":\"ѕ\",\"RightUpVectorBar\":\"⥔\",\"KJcy\":\"Ќ\",\"models\":\"⊧\",\"gtrless\":\"≷\",\"Cscr\":\"𝒞\",\"cemptyv\":\"⦲\",\"caron\":\"ˇ\",\"Rrightarrow\":\"⇛\",\"ap\":\"≈\",\"notin\":\"∉\",\"succnsim\":\"⋩\",\"rBarr\":\"⤏\",\"updownarrow\":\"↕\",\"nwArr\":\"⇖\",\"xoplus\":\"⨁\",\"Otilde\":\"Õ\",\"LT\":\"<\",\"NotSubset\":\"⊂⃒\",\"lesseqgtr\":\"⋚\",\"Ofr\":\"𝔒\",\"NegativeVeryThinSpace\":\"​\",\"frac38\":\"⅜\",\"rarrb\":\"⇥\",\"ulcorner\":\"⌜\",\"lambda\":\"λ\",\"lurdshar\":\"⥊\",\"LeftDownVector\":\"⇃\",\"Sc\":\"⪼\",\"smallsetminus\":\"∖\",\"sum\":\"∑\",\"Wscr\":\"𝒲\",\"zwj\":\"‍\",\"racute\":\"ŕ\",\"kappav\":\"ϰ\",\"sfrown\":\"⌢\",\"rarrc\":\"⤳\",\"Wedge\":\"⋀\",\"exist\":\"∃\",\"lesdot\":\"⩿\",\"sup\":\"⊃\",\"rbrace\":\"}\",\"vnsub\":\"⊂⃒\",\"bnot\":\"⌐\",\"theta\":\"θ\",\"ratio\":\"∶\",\"Mopf\":\"𝕄\",\"Hfr\":\"ℌ\",\"DoubleUpDownArrow\":\"⇕\",\"downharpoonright\":\"⇂\",\"kscr\":\"𝓀\",\"looparrowleft\":\"↫\",\"cylcty\":\"⌭\",\"geqslant\":\"⩾\",\"quot\":\"\\\"\",\"equivDD\":\"⩸\",\"supdsub\":\"⫘\",\"sext\":\"✶\",\"NotGreaterFullEqual\":\"≧̸\",\"circledast\":\"⊛\",\"varsubsetneqq\":\"⫋︀\",\"ddagger\":\"‡\",\"barvee\":\"⊽\",\"NotPrecedes\":\"⊀\",\"RightArrow\":\"→\",\"Element\":\"∈\",\"apacir\":\"⩯\",\"Sacute\":\"Ś\",\"operp\":\"⦹\",\"aopf\":\"𝕒\",\"Ll\":\"⋘\",\"NotSquareSubsetEqual\":\"⋢\",\"rdldhar\":\"⥩\",\"udhar\":\"⥮\",\"upsih\":\"ϒ\",\"VDash\":\"⊫\",\"efDot\":\"≒\",\"wedbar\":\"⩟\",\"GreaterLess\":\"≷\",\"bNot\":\"⫭\",\"ContourIntegral\":\"∮\",\"angrtvb\":\"⊾\",\"Afr\":\"𝔄\",\"hstrok\":\"ħ\",\"NotTildeFullEqual\":\"≇\",\"xcirc\":\"◯\",\"nvge\":\"≥⃒\",\"bigcirc\":\"◯\",\"uharr\":\"↾\",\"rightarrowtail\":\"↣\",\"sup1\":\"¹\",\"Iuml\":\"Ï\",\"Lt\":\"≪\",\"zacute\":\"ź\",\"egrave\":\"è\",\"scsim\":\"≿\",\"Ucy\":\"У\",\"amacr\":\"ā\",\"uopf\":\"𝕦\",\"heartsuit\":\"♥\",\"nleftarrow\":\"↚\",\"sup2\":\"²\",\"Iogon\":\"Į\",\"NotHumpDownHump\":\"≎̸\",\"nlsim\":\"≴\",\"DDotrahd\":\"⤑\",\"xcap\":\"⋂\",\"sup3\":\"³\",\"thinsp\":\" \",\"succcurlyeq\":\"≽\",\"DownRightVectorBar\":\"⥗\",\"reals\":\"ℝ\",\"NegativeMediumSpace\":\"​\",\"odash\":\"⊝\",\"searhk\":\"⤥\",\"xhArr\":\"⟺\",\"nbumpe\":\"≏̸\",\"vartriangleleft\":\"⊲\",\"late\":\"⪭\",\"rarrpl\":\"⥅\",\"acE\":\"∾̳\",\"Jscr\":\"𝒥\",\"curvearrowleft\":\"↶\",\"NotGreaterTilde\":\"≵\",\"olarr\":\"↺\",\"wfr\":\"𝔴\",\"larrtl\":\"↢\",\"RightTriangleEqual\":\"⊵\",\"hookrightarrow\":\"↪\",\"imagpart\":\"ℑ\",\"Ncy\":\"Н\",\"rsaquo\":\"›\",\"varkappa\":\"ϰ\",\"nsmid\":\"∤\",\"VerticalLine\":\"|\",\"dashv\":\"⊣\",\"Psi\":\"Ψ\",\"LeftTeeVector\":\"⥚\",\"fpartint\":\"⨍\",\"orderof\":\"ℴ\",\"boxUL\":\"╝\",\"qint\":\"⨌\",\"varrho\":\"ϱ\",\"dharl\":\"⇃\",\"looparrowright\":\"↬\",\"supseteqq\":\"⫆\",\"RightDoubleBracket\":\"⟧\",\"iff\":\"⇔\",\"isinsv\":\"⋳\",\"cir\":\"○\",\"prod\":\"∏\",\"hyphen\":\"‐\",\"boxuL\":\"╛\",\"mapstoleft\":\"↤\",\"longleftarrow\":\"⟵\",\"Assign\":\"≔\",\"cirfnint\":\"⨐\",\"duhar\":\"⥯\",\"emsp\":\" \",\"coprod\":\"∐\",\"squf\":\"▪\",\"Cconint\":\"∰\",\"curlywedge\":\"⋏\",\"pfr\":\"𝔭\",\"hearts\":\"♥\",\"rarr\":\"→\",\"Topf\":\"𝕋\",\"Gcy\":\"Г\",\"phi\":\"φ\",\"rscr\":\"𝓇\",\"GreaterEqual\":\"≥\",\"Esim\":\"⩳\",\"middot\":\"·\",\"RightArrowLeftArrow\":\"⇄\",\"curarrm\":\"⤼\",\"nsqsupe\":\"⋣\",\"lE\":\"≦\",\"olcross\":\"⦻\",\"iota\":\"ι\",\"sdot\":\"⋅\",\"rbbrk\":\"❳\",\"rangle\":\"⟩\",\"ange\":\"⦤\",\"hopf\":\"𝕙\",\"LongLeftRightArrow\":\"⟷\",\"rArr\":\"⇒\",\"cacute\":\"ć\",\"srarr\":\"→\",\"ltcir\":\"⩹\",\"Updownarrow\":\"⇕\",\"simne\":\"≆\",\"ifr\":\"𝔦\",\"Otimes\":\"⨷\",\"bbrktbrk\":\"⎶\",\"diams\":\"♦\",\"lharul\":\"⥪\",\"vee\":\"∨\",\"gtdot\":\"⋗\",\"lesg\":\"⋚︀\",\"prime\":\"′\",\"spadesuit\":\"♠\",\"OverBrace\":\"⏞\",\"ubrcy\":\"ў\",\"Barwed\":\"⌆\",\"nvgt\":\">⃒\",\"intlarhk\":\"⨗\",\"plussim\":\"⨦\",\"eDDot\":\"⩷\",\"euro\":\"€\",\"ugrave\":\"ù\",\"chcy\":\"ч\",\"Rcaron\":\"Ř\",\"And\":\"⩓\",\"gneq\":\"⪈\",\"lessgtr\":\"≶\",\"EmptySmallSquare\":\"◻\",\"sc\":\"≻\",\"nvrArr\":\"⤃\",\"smte\":\"⪬\",\"nLeftrightarrow\":\"⇎\",\"Equal\":\"⩵\",\"bfr\":\"𝔟\",\"simlE\":\"⪟\",\"rbrack\":\"]\",\"diamondsuit\":\"♦\",\"blacktriangle\":\"▴\",\"PrecedesTilde\":\"≾\",\"twoheadleftarrow\":\"↞\",\"gcirc\":\"ĝ\",\"boxUR\":\"╚\",\"NonBreakingSpace\":\" \",\"dharr\":\"⇂\",\"ExponentialE\":\"ⅇ\",\"Fouriertrf\":\"ℱ\",\"intcal\":\"⊺\",\"Vvdash\":\"⊪\",\"supsim\":\"⫈\",\"LeftDoubleBracket\":\"⟦\",\"Qscr\":\"𝒬\",\"vcy\":\"в\",\"boxuR\":\"╘\",\"nrightarrow\":\"↛\",\"prop\":\"∝\",\"leftrightarrow\":\"↔\",\"DoubleLongLeftRightArrow\":\"⟺\",\"supmult\":\"⫂\",\"nsube\":\"⊈\",\"NotSquareSubset\":\"⊏̸\",\"lfloor\":\"⌊\",\"Aring\":\"Å\",\"SquareUnion\":\"⊔\",\"le\":\"≤\",\"supE\":\"⫆\",\"otilde\":\"õ\",\"acd\":\"∿\",\"Gopf\":\"𝔾\",\"leftrightarrows\":\"⇆\",\"nleqslant\":\"⩽̸\",\"UpTeeArrow\":\"↥\",\"lg\":\"≶\",\"RightCeiling\":\"⌉\",\"prE\":\"⪳\",\"Eogon\":\"Ę\",\"TildeTilde\":\"≈\",\"NotElement\":\"∉\",\"bumpe\":\"≏\",\"UnionPlus\":\"⊎\",\"weierp\":\"℘\",\"escr\":\"ℯ\",\"vnsup\":\"⊃⃒\",\"ClockwiseContourIntegral\":\"∲\",\"nvDash\":\"⊭\",\"ll\":\"≪\",\"NotGreaterLess\":\"≹\",\"DoubleLongLeftArrow\":\"⟸\",\"circledR\":\"®\",\"uwangle\":\"⦧\",\"quatint\":\"⨖\",\"ocy\":\"о\",\"RightTriangle\":\"⊳\",\"ee\":\"ⅇ\",\"LeftTeeArrow\":\"↤\",\"DownRightVector\":\"⇁\",\"Zcaron\":\"Ž\",\"lessapprox\":\"⪅\",\"eg\":\"⪚\",\"gnsim\":\"⋧\",\"nsupE\":\"⫆̸\",\"yscr\":\"𝓎\",\"Lacute\":\"Ĺ\",\"scnsim\":\"⋩\",\"precsim\":\"≾\",\"NotLessGreater\":\"≸\",\"capbrcup\":\"⩉\",\"UpDownArrow\":\"↕\",\"el\":\"⪙\",\"lesseqqgtr\":\"⪋\",\"sigmav\":\"ς\",\"Succeeds\":\"≻\",\"triangle\":\"▵\",\"zdot\":\"ż\",\"Tfr\":\"𝔗\",\"hairsp\":\" \",\"xlarr\":\"⟵\",\"notniva\":\"∌\",\"Colon\":\"∷\",\"precnapprox\":\"⪹\",\"oopf\":\"𝕠\",\"sqcup\":\"⊔\",\"Delta\":\"Δ\",\"gtlPar\":\"⦕\",\"uring\":\"ů\",\"sacute\":\"ś\",\"boxVh\":\"╫\",\"nlArr\":\"⇍\",\"eqslantgtr\":\"⪖\",\"sccue\":\"≽\",\"zeta\":\"ζ\",\"boxvh\":\"┼\",\"LongRightArrow\":\"⟶\",\"propto\":\"∝\",\"csub\":\"⫏\",\"breve\":\"˘\",\"parsim\":\"⫳\",\"rlhar\":\"⇌\",\"Darr\":\"↡\",\"LJcy\":\"Љ\",\"dbkarow\":\"⤏\",\"triangledown\":\"▿\",\"setmn\":\"∖\",\"gnapprox\":\"⪊\",\"rsquo\":\"’\",\"Dscr\":\"𝒟\",\"llhard\":\"⥫\",\"Mfr\":\"𝔐\",\"quest\":\"?\",\"CenterDot\":\"·\",\"prnap\":\"⪹\",\"trianglerighteq\":\"⊵\",\"upuparrows\":\"⇈\",\"Edot\":\"Ė\",\"smile\":\"⌣\",\"acy\":\"а\",\"integers\":\"ℤ\",\"circeq\":\"≗\",\"puncsp\":\" \",\"lates\":\"⪭︀\",\"rarrw\":\"↝\",\"ogt\":\"⧁\",\"swArr\":\"⇙\",\"natural\":\"♮\",\"Xscr\":\"𝒳\",\"orarr\":\"↻\",\"dlcorn\":\"⌞\",\"zigrarr\":\"⇝\",\"Pi\":\"Π\",\"ring\":\"˚\",\"NotLessEqual\":\"≰\",\"notnivb\":\"⋾\",\"DoubleLeftArrow\":\"⇐\",\"npre\":\"⪯̸\",\"ctdot\":\"⋯\",\"rang\":\"⟩\",\"forkv\":\"⫙\",\"Ffr\":\"𝔉\",\"Icirc\":\"Î\",\"thicksim\":\"∼\",\"bne\":\"=⃥\",\"larr\":\"←\",\"Downarrow\":\"⇓\",\"Nopf\":\"ℕ\",\"DoubleRightArrow\":\"⇒\",\"urcorn\":\"⌝\",\"boxVl\":\"╢\",\"leftrightsquigarrow\":\"↭\",\"TripleDot\":\"⃛\",\"Ccaron\":\"Č\",\"lscr\":\"𝓁\",\"Proportion\":\"∷\",\"Zcy\":\"З\",\"boxvl\":\"┤\",\"subedot\":\"⫃\",\"Pr\":\"⪻\",\"rdquor\":\"”\",\"fjlig\":\"fj\",\"nLtv\":\"≪̸\",\"multimap\":\"⊸\",\"nrarrc\":\"⤳̸\",\"LeftVectorBar\":\"⥒\",\"lessdot\":\"⋖\",\"simplus\":\"⨤\",\"Im\":\"ℑ\",\"circledS\":\"Ⓢ\",\"ccirc\":\"ĉ\",\"bopf\":\"𝕓\",\"lArr\":\"⇐\",\"gtrdot\":\"⋗\",\"DoubleDot\":\"¨\",\"andd\":\"⩜\",\"int\":\"∫\",\"sqsupset\":\"⊐\",\"boxminus\":\"⊟\",\"pre\":\"⪯\",\"bdquo\":\"„\",\"CircleMinus\":\"⊖\",\"AMP\":\"&\",\"NegativeThinSpace\":\"​\",\"Not\":\"⫬\",\"boxDL\":\"╗\",\"bigvee\":\"⋁\",\"QUOT\":\"\\\"\",\"boxdL\":\"╕\",\"DScy\":\"Ѕ\",\"Scy\":\"С\",\"nvdash\":\"⊬\",\"blacksquare\":\"▪\",\"mapstoup\":\"↥\",\"LongLeftArrow\":\"⟵\",\"vopf\":\"𝕧\",\"Aogon\":\"Ą\",\"osol\":\"⊘\",\"notnivc\":\"⋽\",\"cup\":\"∪\",\"gsim\":\"≳\",\"DoubleRightTee\":\"⊨\",\"csup\":\"⫐\",\"nlE\":\"≦̸\",\"leqq\":\"≦\",\"zeetrf\":\"ℨ\",\"ffilig\":\"ﬃ\",\"Gamma\":\"Γ\",\"risingdotseq\":\"≓\",\"otimes\":\"⊗\",\"nsubseteqq\":\"⫅̸\",\"origof\":\"⊶\",\"gjcy\":\"ѓ\",\"upsi\":\"υ\",\"npolint\":\"⨔\",\"LeftFloor\":\"⌊\",\"ufr\":\"𝔲\",\"ssetmn\":\"∖\",\"HilbertSpace\":\"ℋ\",\"Congruent\":\"≡\",\"barwed\":\"⌅\",\"Kscr\":\"𝒦\",\"ncongdot\":\"⩭̸\",\"Lcy\":\"Л\",\"ogon\":\"˛\",\"Atilde\":\"Ã\",\"bsime\":\"⋍\",\"subnE\":\"⫋\",\"rmoust\":\"⎱\",\"UpperLeftArrow\":\"↖\",\"rcaron\":\"ř\",\"permil\":\"‰\",\"boxbox\":\"⧉\",\"doteq\":\"≐\",\"homtht\":\"∻\",\"clubs\":\"♣\",\"LeftTriangleEqual\":\"⊴\",\"Aopf\":\"𝔸\",\"glE\":\"⪒\",\"DiacriticalTilde\":\"˜\",\"preccurlyeq\":\"≼\",\"boxVr\":\"╟\",\"Ograve\":\"Ò\",\"varepsilon\":\"ϵ\",\"boxvr\":\"├\",\"shortmid\":\"∣\",\"nfr\":\"𝔫\",\"iinfin\":\"⧜\",\"uogon\":\"ų\",\"andslope\":\"⩘\",\"rarrfs\":\"⤞\",\"LessGreater\":\"≶\",\"roang\":\"⟭\",\"Ecy\":\"Э\",\"FilledVerySmallSquare\":\"▪\",\"xsqcup\":\"⨆\",\"rightthreetimes\":\"⋌\",\"Uopf\":\"𝕌\",\"Vdashl\":\"⫦\",\"Ubreve\":\"Ŭ\",\"tau\":\"τ\",\"epsilon\":\"ε\",\"sscr\":\"𝓈\",\"VerticalTilde\":\"≀\",\"Scaron\":\"Š\",\"there4\":\"∴\",\"rnmid\":\"⫮\",\"boxDR\":\"╔\",\"DownArrowUpArrow\":\"⇵\",\"NotDoubleVerticalBar\":\"∦\",\"ltquest\":\"⩻\",\"Eacute\":\"É\",\"varsupsetneqq\":\"⫌︀\",\"tdot\":\"⃛\",\"map\":\"↦\",\"equest\":\"≟\",\"boxdR\":\"╒\",\"utri\":\"▵\",\"varpi\":\"ϖ\",\"sstarf\":\"⋆\",\"roplus\":\"⨮\",\"ruluhar\":\"⥨\",\"Itilde\":\"Ĩ\",\"IJlig\":\"Ĳ\",\"supe\":\"⊇\",\"gfr\":\"𝔤\",\"iopf\":\"𝕚\",\"gnap\":\"⪊\",\"Mellintrf\":\"ℳ\",\"bsol\":\"\\\\\",\"eparsl\":\"⧣\",\"gnE\":\"≩\",\"zcaron\":\"ž\",\"rbarr\":\"⤍\",\"RightDownTeeVector\":\"⥝\",\"rightarrow\":\"→\",\"acute\":\"´\",\"frac23\":\"⅔\",\"omega\":\"ω\",\"lacute\":\"ĺ\",\"suphsub\":\"⫗\",\"rhard\":\"⇁\",\"CircleDot\":\"⊙\",\"npart\":\"∂̸\",\"Dagger\":\"‡\",\"xrarr\":\"⟶\",\"Ecirc\":\"Ê\",\"varsubsetneq\":\"⊊︀\",\"elsdot\":\"⪗\",\"erDot\":\"≓\",\"trisb\":\"⧍\",\"gesdoto\":\"⪂\",\"toea\":\"⤨\",\"lbrace\":\"{\",\"ltdot\":\"⋖\",\"nrArr\":\"⇏\",\"notinva\":\"∉\",\"nsccue\":\"⋡\",\"NotLess\":\"≮\",\"andv\":\"⩚\",\"nsim\":\"≁\",\"LeftArrow\":\"←\",\"wp\":\"℘\",\"Square\":\"□\",\"nwarrow\":\"↖\",\"iecy\":\"е\",\"njcy\":\"њ\",\"wr\":\"≀\",\"rceil\":\"⌉\",\"rbrke\":\"⦌\",\"Rarr\":\"↠\",\"euml\":\"ë\",\"pi\":\"π\",\"tcy\":\"т\",\"telrec\":\"⌕\",\"nrtrie\":\"⋭\",\"Diamond\":\"⋄\",\"Rscr\":\"ℛ\",\"cupor\":\"⩅\",\"pm\":\"±\",\"lobrk\":\"⟦\",\"ic\":\"⁣\",\"xutri\":\"△\",\"Union\":\"⋃\",\"NotSupersetEqual\":\"⊉\",\"nle\":\"≰\",\"precapprox\":\"⪷\",\"Iota\":\"Ι\",\"Rcedil\":\"Ŗ\",\"aelig\":\"æ\",\"lAarr\":\"⇚\",\"lang\":\"⟨\",\"RightUpTeeVector\":\"⥜\",\"pr\":\"≺\",\"sqsupe\":\"⊒\",\"Hopf\":\"ℍ\",\"Vdash\":\"⊩\",\"bemptyv\":\"⦰\",\"Yfr\":\"𝔜\",\"Umacr\":\"Ū\",\"ii\":\"ⅈ\",\"bigstar\":\"★\",\"yuml\":\"ÿ\",\"rdca\":\"⤷\",\"xodot\":\"⨀\",\"ycirc\":\"ŷ\",\"lowast\":\"∗\",\"frac25\":\"⅖\",\"fscr\":\"𝒻\",\"supsub\":\"⫔\",\"quaternions\":\"ℍ\",\"gla\":\"⪥\",\"Tilde\":\"∼\",\"plankv\":\"ℏ\",\"Bumpeq\":\"≎\",\"in\":\"∈\",\"mcy\":\"м\",\"ThinSpace\":\" \",\"gvertneqq\":\"≩︀\",\"becaus\":\"∵\",\"upharpoonleft\":\"↿\",\"cuepr\":\"⋞\",\"gdot\":\"ġ\",\"notinvb\":\"⋷\",\"varsigma\":\"ς\",\"esdot\":\"≐\",\"it\":\"⁢\",\"LeftTee\":\"⊣\",\"omacr\":\"ō\",\"zscr\":\"𝓏\",\"larrpl\":\"⤹\",\"midast\":\"*\",\"ccaron\":\"č\",\"DotEqual\":\"≐\",\"check\":\"✓\",\"Rfr\":\"ℜ\",\"nvap\":\"≍⃒\",\"Conint\":\"∯\",\"lnsim\":\"⋦\",\"hardcy\":\"ъ\",\"Uacute\":\"Ú\",\"glj\":\"⪤\",\"lsaquo\":\"‹\",\"mnplus\":\"∓\",\"fcy\":\"ф\",\"succnapprox\":\"⪺\",\"popf\":\"𝕡\",\"Longrightarrow\":\"⟹\",\"ngsim\":\"≵\",\"emptyv\":\"∅\",\"LeftTriangleBar\":\"⧏\"}"
