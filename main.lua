-----------------------------------------------------------------------------------------
-- Title: Math Quiz
-- Name: Dante Beltran		
-- Course: ICS2O/3C
-- This program creates a math quiz that asks various different questions(add,subtraction,multiply, etc)
-----------------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar(display.HiddenStatusBar)

-- sets the backround colour
display.setDefault("background", 10/255, 20/255, 50/255)

-------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-------------------------------------------------------------------------------------

-- create local variables
local questionObject
local correctObject
local numericFeild
local randomNumber1
local randomNumber2
local userAnswer
local correctAnswer
local operator
local gameOverScreen
local score = 0
local scoreText
local winGameScreen
local product = 1


-- variables for the timer
local totalSeconds = 10
local secondsLeft = 10
local clockText
local countDownTimer

-- variables for lives
local lives = 3
local heart1
local heart2
local heart3


-------------------------------------------------------------------------------------
-- Sounds
-------------------------------------------------------------------------------------

-- load sounds
local gameOver = audio.loadSound("Sounds/Game Over Sound.mp3")
local correctSound = audio.loadSound("Sounds/Correct Sound.mp3")
local wrongBuzz = audio.loadSound("Sounds/Wrong Buzz.mp3")
local winGame = audio.loadSound("Sounds/You Win Sound.mp3")


-------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-------------------------------------------------------------------------------------

local function AskQuestion()
	-- create an operator that picks a random equation  every time
	operator = math.random(1, 7)

		if (operator == 1) then

		-- generate 2 random numbers between a max. and a min. number
		randomNumber1 = math.random(1, 10)
		randomNumber2 = math.random(1, 10)
		-- set the answer of the question
		correctAnswer = randomNumber1 + randomNumber2
	
		-- create question in text object
		questionObject.text = randomNumber1 .. " + " .. randomNumber2 .. " = "
	

	elseif (operator == 2) then
		-- generate 2 random numbers between a max. and a min. number
		randomNumber1 = math.random(10, 20)
		randomNumber2 = math.random(10, 20)
		-- set the answer of the question
		if (randomNumber2 > randomNumber1) then
			correctAnswer = randomNumber2 - randomNumber1
			-- create question in text object
			questionObject.text = randomNumber2 .. " - " .. randomNumber1 .. " = "
		else
			correctAnswer = randomNumber1 - randomNumber2
			-- create question in text object
			questionObject.text = randomNumber1 .. " - " .. randomNumber2 .. " = "
		end

	elseif (operator == 3) then
		-- generate 2 random numbers between a max. and a min. number
		randomNumber1 = math.random(1, 10)
		randomNumber2 = math.random(1, 10)
		-- set the answer of the question
		correctAnswer = randomNumber1 * randomNumber2
	
		-- create question in text object
		questionObject.text = randomNumber1 .. " * " .. randomNumber2 .. " = "

	elseif (operator == 4) then
		-- generate 2 random numbers between a max. and a min. number
		randomNumber1 = math.random(1, 10)
		randomNumber2 = math.random(1, 10)
		-- set the answer of the question
		correctAnswer = randomNumber1 * randomNumber2
	
		-- create question in text object
		questionObject.text = correctAnswer .. " / " .. randomNumber2 .. " = "
		correctAnswer = randomNumber1

	elseif (operator == 5) then

		-- generate 2 random numbers between a max. and a min. number
		randomNumber1 = math.random(1, 10)
		randomNumber2 = math.random(1, 3)
		-- set the answer of the question
		correctAnswer = randomNumber1 ^ randomNumber2
	
		-- create question in text object
		questionObject.text = randomNumber1 .. " ^ " .. randomNumber2 .. " = "

	elseif (operator == 6) then

		-- generate 2 random numbers between a max. and a min. number
		randomNumber1 = math.random(1, 10)
		correctAnswer = randomNumber1 * randomNumber1

	-- create question in text object
		questionObject.text = " √ "..correctAnswer .. " = "

		--set the the answer of the random question
		correctAnswer = math.sqrt(correctAnswer)
	
	elseif (operator == 7) then

		-- generate a random number between  a max. and a min. number
		randomNumber1 = math.random(1, 5)
		--set the correct answer  for the question
		for i = 1, randomNumber1 do 
			product = product * i 
		end
		correctAnswer = product

		--create question in text object
		questionObject.text = randomNumber1.."!".. " ="
	end
end

local function WinGame()
	-- when score equals 5 the user wins the game 
	if (score == 5) then
		winGameScreen.isVisible = true
		numericField.isVisible = false
		clockText.isVisible = false
		questionObject.isVisible = false
		scoreText.isVisible = false
		audio.play(winGame)
		audio.dispose(gameOver)
	end
end


local function GameOver()
	-- when lives equal zero display game over screen
	if (lives == 0) then
		gameOverScreen.isVisible = true
		numericField.isVisible = false
		clockText.isVisible = false
		questionObject.isVisible = false
		scoreText.isVisible = false
		audio.play(gameOver)
	end
end

local function UpdateHeart()
	-- hearts
	if (lives == 3) then 
		heart1.isVisible = true
		heart2.isVisible = true
		heart3.isVisible = true
	elseif (lives == 2) then 
		heart1.isVisible = true
		heart2.isVisible = true
		heart3.isVisible = false
	elseif (lives == 1) then 
		heart1.isVisible = true
		heart2.isVisible = false
		heart3.isVisible = false
	elseif (lives == 0) then 
		heart1.isVisible = false
		heart2.isVisible = false
		heart3.isVisible = false
		GameOver()
	end	
end

local function UpdateTime()
	-- decrement the number of seconds
	secondsLeft = secondsLeft - 1

	-- display the number of seconds left in the clock object
	clockText.text = secondsLeft .. ""

	if (secondsLeft == 0 ) then
		-- reset the number of seconds left
		secondsLeft = totalSeconds
		lives = lives -1
		UpdateHeart()
		AskQuestion()
	end
end



-- function that calls the timer
local function StartTimer()

	-- create a countdown timer that loops infinetly
	countDownTimer = timer.performWithDelay(1000, UpdateTime, 0)
end


local function  HideCorrect()
	--hide the correct object
	correctObject.isVisible = false
	AskQuestion()
end

local function HideIncorrect()
	-- hide the incorrect object
	incorrectObject.isVisible = false
	AskQuestion()
end

local function UpdateScore()

	-- update score
	score = score + 1
	scoreText.text = string.format("Score: %d", score)
	WinGame()
end

local function NumericFeildListener( event )

	-- User begins editing "numericField" 
	if ( event.phase == "began" ) then
		

	elseif event.phase == "submitted" then

		-- when the answer is sumbmitted (enter key is pressed) set user input to user's 
		-- answer 
		userAnswer = tonumber(event.target.text)

		-- if the users answer and the correct answer are the same:
		if (userAnswer == correctAnswer) then
			correctObject.isVisible = true
			timer.performWithDelay(3000, HideCorrect)
			event.target.text = ""
			audio.play(correctSound)
			secondsLeft = totalSeconds
			UpdateScore()
			
		else
			-- if the answers are not the same
			incorrectObject.isVisible = true
			timer.performWithDelay(3000, HideIncorrect) 
			event.target.text = ""
			secondsLeft = totalSeconds
			audio.play(wrongBuzz)
			lives = lives -1
			UpdateHeart()
		end
	end
end

--------------------------------------------------------------------------------------
-- OBJECT CREATION
--------------------------------------------------------------------------------------

-- displays a question and sets the color
questionObject = display.newText( "", display.contentWidth/3, 
	display.contentHeight/3, nil, 60 )
questionObject:setTextColor(190/255, 100/255, 30/255)

-- create the correct text object and make it invisible
correctObject = display.newText( "Correct!", display.contentWidth/2, 
	display.contentHeight*2/3, nil, 50 )
correctObject:setTextColor(190/255, 100/255, 30/255)
correctObject.isVisible = false

-- create the incorrect text object and make it invisible
incorrectObject = display.newText( "Incorrect!", display.contentWidth/2, 
	display.contentHeight*2/3, nil, 50 )
incorrectObject:setTextColor(190/255, 0/255, 0/255)
incorrectObject.isVisible = false

-- create numeric field
numericField = native.newTextField( 550, display.contentHeight/3, 150, 80)
numericField.inputType = "number"

-- add the event listener for the numeric field
numericField:addEventListener( "userInput", NumericFeildListener)

clockText = display.newText( "", display.contentWidth/2, 
	display.contentHeight/5 * 4, nil, 60 )
clockText:setTextColor(190/255, 100/255, 30/255)

-- create the lives to display on the screen
heart1 = display.newImageRect("Images/heart.png", 100, 100)
heart1.x = display.contentWidth * 7 / 8
heart1.y = display.contentHeight * 1 / 7

heart2 = display.newImageRect("Images/heart.png", 100, 100)
heart2.x = display.contentWidth * 6 / 8
heart2.y = display.contentHeight * 1 / 7

heart3 = display.newImageRect("Images/heart.png", 100, 100)
heart3.x = display.contentWidth * 5 / 8
heart3.y = display.contentHeight * 1 / 7

-- create the game over image
gameOverScreen = display.newImageRect("Images/gameOver.png", 1000, 1000)
gameOverScreen.x = display.contentWidth/2
gameOverScreen.y = display.contentHeight/2
gameOverScreen.isVisible = false

-- create the Win game image
winGameScreen = display.newImageRect("Images/Win Screen.png", 1000, 1000)
winGameScreen.x = display.contentWidth/2
winGameScreen.y = display.contentHeight/2
winGameScreen.isVisible = false

-- create the score text
scoreText = display.newText( "Score: 0", display.contentHeight * 2 / 8,
 display.contentWidth * 1 / 8, "Helvetica", 50 )
scoreText:setTextColor(190/255, 100/255, 30/255)
scoreText.isVisible = true


---------------------------------------------------------------------------------------
-- FUNCTION CALLS
---------------------------------------------------------------------------------------

-- call the function to ask the question
UpdateHeart()
GameOver()
StartTimer()
AskQuestion()
UpdateTime()
WinGame()