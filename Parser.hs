{-# OPTIONS_GHC -w #-}
module Parser(parse) where
import  Lexer
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.19.5

data HappyAbsSyn t4 t5 t6 t7 t8 t9 t10 t11
	= HappyTerminal (Token)
	| HappyErrorToken Int
	| HappyAbsSyn4 t4
	| HappyAbsSyn5 t5
	| HappyAbsSyn6 t6
	| HappyAbsSyn7 t7
	| HappyAbsSyn8 t8
	| HappyAbsSyn9 t9
	| HappyAbsSyn10 t10
	| HappyAbsSyn11 t11

action_0 (18) = happyShift action_4
action_0 (19) = happyShift action_5
action_0 (23) = happyShift action_6
action_0 (35) = happyShift action_7
action_0 (36) = happyShift action_8
action_0 (37) = happyShift action_9
action_0 (4) = happyGoto action_10
action_0 (7) = happyGoto action_2
action_0 (8) = happyGoto action_3
action_0 _ = happyFail

action_1 (18) = happyShift action_4
action_1 (19) = happyShift action_5
action_1 (23) = happyShift action_6
action_1 (35) = happyShift action_7
action_1 (36) = happyShift action_8
action_1 (37) = happyShift action_9
action_1 (7) = happyGoto action_2
action_1 (8) = happyGoto action_3
action_1 _ = happyFail

action_2 (18) = happyShift action_4
action_2 (19) = happyShift action_5
action_2 (23) = happyShift action_6
action_2 (35) = happyShift action_7
action_2 (36) = happyShift action_8
action_2 (37) = happyShift action_9
action_2 (38) = happyShift action_27
action_2 (8) = happyGoto action_26
action_2 _ = happyFail

action_3 _ = happyReduce_8

action_4 (37) = happyShift action_25
action_4 _ = happyFail

action_5 (15) = happyShift action_18
action_5 (16) = happyShift action_19
action_5 (17) = happyShift action_20
action_5 (30) = happyShift action_21
action_5 (33) = happyShift action_22
action_5 (37) = happyShift action_23
action_5 (6) = happyGoto action_14
action_5 (9) = happyGoto action_24
action_5 (10) = happyGoto action_16
action_5 (11) = happyGoto action_17
action_5 _ = happyFail

action_6 (15) = happyShift action_18
action_6 (16) = happyShift action_19
action_6 (17) = happyShift action_20
action_6 (30) = happyShift action_21
action_6 (33) = happyShift action_22
action_6 (37) = happyShift action_23
action_6 (6) = happyGoto action_14
action_6 (9) = happyGoto action_15
action_6 (10) = happyGoto action_16
action_6 (11) = happyGoto action_17
action_6 _ = happyFail

action_7 (37) = happyShift action_13
action_7 _ = happyFail

action_8 (37) = happyShift action_12
action_8 _ = happyFail

action_9 (26) = happyShift action_11
action_9 _ = happyFail

action_10 (39) = happyAccept
action_10 _ = happyFail

action_11 (15) = happyShift action_18
action_11 (16) = happyShift action_19
action_11 (17) = happyShift action_20
action_11 (30) = happyShift action_21
action_11 (33) = happyShift action_22
action_11 (37) = happyShift action_23
action_11 (6) = happyGoto action_14
action_11 (9) = happyGoto action_39
action_11 (10) = happyGoto action_16
action_11 (11) = happyGoto action_17
action_11 _ = happyFail

action_12 (27) = happyShift action_38
action_12 _ = happyFail

action_13 (27) = happyShift action_37
action_13 _ = happyFail

action_14 _ = happyReduce_24

action_15 (24) = happyShift action_36
action_15 (29) = happyShift action_30
action_15 (30) = happyShift action_31
action_15 _ = happyFail

action_16 (31) = happyShift action_34
action_16 (32) = happyShift action_35
action_16 _ = happyReduce_18

action_17 _ = happyReduce_21

action_18 _ = happyReduce_7

action_19 _ = happyReduce_5

action_20 _ = happyReduce_6

action_21 (15) = happyShift action_18
action_21 (16) = happyShift action_19
action_21 (17) = happyShift action_20
action_21 (30) = happyShift action_21
action_21 (33) = happyShift action_22
action_21 (37) = happyShift action_23
action_21 (6) = happyGoto action_14
action_21 (11) = happyGoto action_33
action_21 _ = happyFail

action_22 (15) = happyShift action_18
action_22 (16) = happyShift action_19
action_22 (17) = happyShift action_20
action_22 (30) = happyShift action_21
action_22 (33) = happyShift action_22
action_22 (37) = happyShift action_23
action_22 (6) = happyGoto action_14
action_22 (9) = happyGoto action_32
action_22 (10) = happyGoto action_16
action_22 (11) = happyGoto action_17
action_22 _ = happyFail

action_23 _ = happyReduce_25

action_24 (20) = happyShift action_29
action_24 (29) = happyShift action_30
action_24 (30) = happyShift action_31
action_24 _ = happyFail

action_25 (28) = happyShift action_28
action_25 _ = happyFail

action_26 _ = happyReduce_9

action_27 _ = happyReduce_1

action_28 (12) = happyShift action_49
action_28 (13) = happyShift action_50
action_28 (14) = happyShift action_51
action_28 (5) = happyGoto action_48
action_28 _ = happyFail

action_29 (18) = happyShift action_4
action_29 (19) = happyShift action_5
action_29 (23) = happyShift action_6
action_29 (35) = happyShift action_7
action_29 (36) = happyShift action_8
action_29 (37) = happyShift action_9
action_29 (7) = happyGoto action_47
action_29 (8) = happyGoto action_3
action_29 _ = happyFail

action_30 (15) = happyShift action_18
action_30 (16) = happyShift action_19
action_30 (17) = happyShift action_20
action_30 (30) = happyShift action_21
action_30 (33) = happyShift action_22
action_30 (37) = happyShift action_23
action_30 (6) = happyGoto action_14
action_30 (10) = happyGoto action_46
action_30 (11) = happyGoto action_17
action_30 _ = happyFail

action_31 (15) = happyShift action_18
action_31 (16) = happyShift action_19
action_31 (17) = happyShift action_20
action_31 (30) = happyShift action_21
action_31 (33) = happyShift action_22
action_31 (37) = happyShift action_23
action_31 (6) = happyGoto action_14
action_31 (10) = happyGoto action_45
action_31 (11) = happyGoto action_17
action_31 _ = happyFail

action_32 (29) = happyShift action_30
action_32 (30) = happyShift action_31
action_32 (34) = happyShift action_44
action_32 _ = happyFail

action_33 _ = happyReduce_23

action_34 (15) = happyShift action_18
action_34 (16) = happyShift action_19
action_34 (17) = happyShift action_20
action_34 (30) = happyShift action_21
action_34 (33) = happyShift action_22
action_34 (37) = happyShift action_23
action_34 (6) = happyGoto action_14
action_34 (11) = happyGoto action_43
action_34 _ = happyFail

action_35 (15) = happyShift action_18
action_35 (16) = happyShift action_19
action_35 (17) = happyShift action_20
action_35 (30) = happyShift action_21
action_35 (33) = happyShift action_22
action_35 (37) = happyShift action_23
action_35 (6) = happyGoto action_14
action_35 (11) = happyGoto action_42
action_35 _ = happyFail

action_36 (18) = happyShift action_4
action_36 (19) = happyShift action_5
action_36 (23) = happyShift action_6
action_36 (35) = happyShift action_7
action_36 (36) = happyShift action_8
action_36 (37) = happyShift action_9
action_36 (7) = happyGoto action_41
action_36 (8) = happyGoto action_3
action_36 _ = happyFail

action_37 _ = happyReduce_12

action_38 _ = happyReduce_13

action_39 (27) = happyShift action_40
action_39 (29) = happyShift action_30
action_39 (30) = happyShift action_31
action_39 _ = happyFail

action_40 _ = happyReduce_15

action_41 (18) = happyShift action_4
action_41 (19) = happyShift action_5
action_41 (23) = happyShift action_6
action_41 (25) = happyShift action_54
action_41 (35) = happyShift action_7
action_41 (36) = happyShift action_8
action_41 (37) = happyShift action_9
action_41 (8) = happyGoto action_26
action_41 _ = happyFail

action_42 _ = happyReduce_20

action_43 _ = happyReduce_19

action_44 _ = happyReduce_22

action_45 (31) = happyShift action_34
action_45 (32) = happyShift action_35
action_45 _ = happyReduce_17

action_46 (31) = happyShift action_34
action_46 (32) = happyShift action_35
action_46 _ = happyReduce_16

action_47 (18) = happyShift action_4
action_47 (19) = happyShift action_5
action_47 (21) = happyShift action_53
action_47 (23) = happyShift action_6
action_47 (35) = happyShift action_7
action_47 (36) = happyShift action_8
action_47 (37) = happyShift action_9
action_47 (8) = happyGoto action_26
action_47 _ = happyFail

action_48 (27) = happyShift action_52
action_48 _ = happyFail

action_49 _ = happyReduce_4

action_50 _ = happyReduce_2

action_51 _ = happyReduce_3

action_52 _ = happyReduce_14

action_53 (18) = happyShift action_4
action_53 (19) = happyShift action_5
action_53 (23) = happyShift action_6
action_53 (35) = happyShift action_7
action_53 (36) = happyShift action_8
action_53 (37) = happyShift action_9
action_53 (7) = happyGoto action_55
action_53 (8) = happyGoto action_3
action_53 _ = happyFail

action_54 _ = happyReduce_11

action_55 (18) = happyShift action_4
action_55 (19) = happyShift action_5
action_55 (22) = happyShift action_56
action_55 (23) = happyShift action_6
action_55 (35) = happyShift action_7
action_55 (36) = happyShift action_8
action_55 (37) = happyShift action_9
action_55 (8) = happyGoto action_26
action_55 _ = happyFail

action_56 _ = happyReduce_10

happyReduce_1 = happySpecReduce_2  4 happyReduction_1
happyReduction_1 _
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn4
		 (Program happy_var_1
	)
happyReduction_1 _ _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_1  5 happyReduction_2
happyReduction_2 _
	 =  HappyAbsSyn5
		 (TypeFloat
	)

happyReduce_3 = happySpecReduce_1  5 happyReduction_3
happyReduction_3 _
	 =  HappyAbsSyn5
		 (TypeString
	)

happyReduce_4 = happySpecReduce_1  5 happyReduction_4
happyReduction_4 _
	 =  HappyAbsSyn5
		 (TypeInt
	)

happyReduce_5 = happySpecReduce_1  6 happyReduction_5
happyReduction_5 _
	 =  HappyAbsSyn6
		 (FloatLit
	)

happyReduce_6 = happySpecReduce_1  6 happyReduction_6
happyReduction_6 _
	 =  HappyAbsSyn6
		 (StringLit
	)

happyReduce_7 = happySpecReduce_1  6 happyReduction_7
happyReduction_7 _
	 =  HappyAbsSyn6
		 (IntLit
	)

happyReduce_8 = happySpecReduce_1  7 happyReduction_8
happyReduction_8 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn7
		 ([ happy_var_1]
	)
happyReduction_8 _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_2  7 happyReduction_9
happyReduction_9 (HappyAbsSyn8  happy_var_2)
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_2 : happy_var_1
	)
happyReduction_9 _ _  = notHappyAtAll 

happyReduce_10 = happyReduce 7 8 happyReduction_10
happyReduction_10 (_ `HappyStk`
	(HappyAbsSyn7  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn9  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn8
		 (SIf happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_11 = happyReduce 5 8 happyReduction_11
happyReduction_11 (_ `HappyStk`
	(HappyAbsSyn7  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn9  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn8
		 (SWhile happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_12 = happySpecReduce_3  8 happyReduction_12
happyReduction_12 _
	(HappyTerminal (TId happy_var_2))
	_
	 =  HappyAbsSyn8
		 (SPrint happy_var_2
	)
happyReduction_12 _ _ _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_3  8 happyReduction_13
happyReduction_13 _
	(HappyTerminal (TId happy_var_2))
	_
	 =  HappyAbsSyn8
		 (SRead happy_var_2
	)
happyReduction_13 _ _ _  = notHappyAtAll 

happyReduce_14 = happyReduce 5 8 happyReduction_14
happyReduction_14 (_ `HappyStk`
	(HappyAbsSyn5  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TId happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn8
		 (SDec happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_15 = happyReduce 4 8 happyReduction_15
happyReduction_15 (_ `HappyStk`
	(HappyAbsSyn9  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TId happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn8
		 (SAssign happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_16 = happySpecReduce_3  9 happyReduction_16
happyReduction_16 (HappyAbsSyn10  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn9
		 (EPlus happy_var_1 happy_var_3
	)
happyReduction_16 _ _ _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_3  9 happyReduction_17
happyReduction_17 (HappyAbsSyn10  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn9
		 (EMinus happy_var_1 happy_var_3
	)
happyReduction_17 _ _ _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_1  9 happyReduction_18
happyReduction_18 (HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn9
		 (ETerm happy_var_1
	)
happyReduction_18 _  = notHappyAtAll 

happyReduce_19 = happySpecReduce_3  10 happyReduction_19
happyReduction_19 (HappyAbsSyn11  happy_var_3)
	_
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn10
		 (TTimes happy_var_1 happy_var_3
	)
happyReduction_19 _ _ _  = notHappyAtAll 

happyReduce_20 = happySpecReduce_3  10 happyReduction_20
happyReduction_20 (HappyAbsSyn11  happy_var_3)
	_
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn10
		 (TDiv happy_var_1 happy_var_3
	)
happyReduction_20 _ _ _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_1  10 happyReduction_21
happyReduction_21 (HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn10
		 (TFac happy_var_1
	)
happyReduction_21 _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_3  11 happyReduction_22
happyReduction_22 _
	(HappyAbsSyn9  happy_var_2)
	_
	 =  HappyAbsSyn11
		 (FPar happy_var_2
	)
happyReduction_22 _ _ _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_2  11 happyReduction_23
happyReduction_23 (HappyAbsSyn11  happy_var_2)
	_
	 =  HappyAbsSyn11
		 (FNeg happy_var_2
	)
happyReduction_23 _ _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_1  11 happyReduction_24
happyReduction_24 _
	 =  HappyAbsSyn11
		 (FLit
	)

happyReduce_25 = happySpecReduce_1  11 happyReduction_25
happyReduction_25 _
	 =  HappyAbsSyn11
		 (FId
	)

happyNewToken action sts stk [] =
	action 39 39 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	TIntType -> cont 12;
	TFloatType -> cont 13;
	TStringType -> cont 14;
	TIntLit happy_dollar_dollar -> cont 15;
	TFloatLit happy_dollar_dollar -> cont 16;
	TStringLit happy_dollar_dollar -> cont 17;
	TVar -> cont 18;
	TIf -> cont 19;
	TThen -> cont 20;
	TElse -> cont 21;
	TEndif -> cont 22;
	TWhile -> cont 23;
	TDo -> cont 24;
	TDone -> cont 25;
	TEquals -> cont 26;
	TSemiColon -> cont 27;
	TColon -> cont 28;
	TPlus -> cont 29;
	TMinus -> cont 30;
	TStar -> cont 31;
	TSlash -> cont 32;
	TLeftParen -> cont 33;
	TRightParen -> cont 34;
	TPrint -> cont 35;
	TRead -> cont 36;
	TId happy_dollar_dollar -> cont 37;
	TEOF -> cont 38;
	_ -> happyError' (tk:tks)
	}

happyError_ 39 tk tks = happyError' tks
happyError_ _ tk tks = happyError' (tk:tks)

newtype HappyIdentity a = HappyIdentity a
happyIdentity = HappyIdentity
happyRunIdentity (HappyIdentity a) = a

instance Functor HappyIdentity where
    fmap f (HappyIdentity a) = HappyIdentity (f a)

instance Applicative HappyIdentity where
    pure  = return
    (<*>) = ap
instance Monad HappyIdentity where
    return = HappyIdentity
    (HappyIdentity p) >>= q = q p

happyThen :: () => HappyIdentity a -> (a -> HappyIdentity b) -> HappyIdentity b
happyThen = (>>=)
happyReturn :: () => a -> HappyIdentity a
happyReturn = (return)
happyThen1 m k tks = (>>=) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> HappyIdentity a
happyReturn1 = \a tks -> (return) a
happyError' :: () => [(Token)] -> HappyIdentity a
happyError' = HappyIdentity . parseError

parse tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


parseError :: [Token] -> a
parseError _ = error "Parse error"


data Program
    = Program StatementList
      deriving (Show, Eq)

data Type =
    TypeInt
    | TypeFloat
    | TypeString
    deriving (Show, Eq)

data Literal =
     FloatLit Float
     | StringLit String
     |  IntLit Int
     deriving (Show, Eq)

data Statement
    = SIf Exp StatementList StatementList
    | SWhile Exp StatementList
    | SPrint Id
    | SRead Id
    | SAssign Id Exp
    | SDec Id Type
    deriving (Show, Eq)

--data StatementList
--  = StatementList Statement
-- | Empty
--deriving (Show, Eq)


data Exp
    = EPlus Exp Term
    | EMinus Exp Term
    | ETerm Term
    deriving (Show, Eq)

data Term
    = TTimes Term Factor
    | TDiv Term Factor
    | TFac Factor
    deriving (Show, Eq)

data Factor
    = FPar Exp
    | FNeg Factor
    | FLit
    | FId
    deriving (Show, Eq)

type StatementList = [Statement]
type Id = String
--type Integer_Literal = Int
--type Float_Literal = Float
--type String_Literal = String

main = do
  inStr <- getContents
  let parseTree = parse (scan inStr)
  putStrLn ("parseTree: " ++ show(parseTree))
  print "done"
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "<built-in>" #-}
{-# LINE 1 "<command-line>" #-}







# 1 "/usr/include/stdc-predef.h" 1 3 4

# 17 "/usr/include/stdc-predef.h" 3 4










































{-# LINE 7 "<command-line>" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp 

{-# LINE 13 "templates/GenericTemplate.hs" #-}

{-# LINE 46 "templates/GenericTemplate.hs" #-}








{-# LINE 67 "templates/GenericTemplate.hs" #-}

{-# LINE 77 "templates/GenericTemplate.hs" #-}

{-# LINE 86 "templates/GenericTemplate.hs" #-}

infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is (1), it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action

{-# LINE 155 "templates/GenericTemplate.hs" #-}

-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Int ->                    -- token number
         Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k - ((1) :: Int)) sts of
         sts1@(((st1@(HappyState (action))):(_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
         let drop_stk = happyDropStk k stk





             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n - ((1) :: Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n - ((1)::Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction

{-# LINE 256 "templates/GenericTemplate.hs" #-}
happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery ((1) is the error token)

-- parse error if we are in recovery and we fail again
happyFail (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  (1) tk old_st (((HappyState (action))):(sts)) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        action (1) (1) tk (HappyState (action)) sts ((saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail  i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action (1) (1) tk (HappyState (action)) sts ( (HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.

{-# LINE 322 "templates/GenericTemplate.hs" #-}
{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
