-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

--1) 게임에 사용될 랜덤함수 미리 초기화
   math.randomseed(os.time())
--2) widget 라이브러리 추가(아래서 사용할 것임)
local widget = require("widget")
--3) 점수 변수 선언
local score = 0
--4) GUI 요소들 선언 
local background
local counter
local gameUI = {}
local customer = {}
local menu = {}
local order
local hpDownNum = 10--길이에 맞춰 조절해야함
local hpXDownNum = 5
local mentalityDownNum = 10
local mentalitXyDownNum = 5

function scene:create( event )
   local sceneGroup = self.view
   --gameUI[2].x = composer.getVariable(gameUI[2].x) 
  --gameUI[2].width = composer.getVariable(gameUI[2].width) 

   background = display.newImageRect("image/cook_BG.png",  display.contentWidth, display.contentHeight)
   background.x, background.y = display.contentWidth/2, display.contentHeight/2
   --씬 이동부분--
   local function toCounter()
      composer.gotoScene("counter")
   end

   --전환
   gameUI[8] = widget.newButton({
      defaultFile = "image/arrow.png", overFile = "Fruit/input_L_over.png",
      width = 80, height = 80, onPress = toCounter -- 버튼을 누르면 inputEvent
   })
   gameUI[8].x, gameUI[8].y = display.contentWidth-1200, display.contentHeight/2
   gameUI[8].name = "arrow"
   gameUI[8]:rotate(180)

   --composer.setVariable(gameUI[2].x, gameUI[2].x)
   --composer.setVariable(gameUI[2].width, gameUI[2].width)

   sceneGroup:insert(background)
   sceneGroup:insert(gameUI[8])
   
   end

function scene:show( event )
   local sceneGroup = self.view
   local phase = event.phase
   
   if phase == "will" then
   elseif phase == "did" then
      -- e.g. start timers, begin animation, play audio, etc.
   end   
end

function scene:hide( event )
   local sceneGroup = self.view
   local phase = event.phase
   
   if event.phase == "will" then
      composer.removeScene("cook")
   elseif phase == "did" then
   end
end

function scene:destroy( event )
   local sceneGroup = self.view
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene