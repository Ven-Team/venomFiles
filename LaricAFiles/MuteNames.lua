local function MuteNames(msg)
local text = msg.content_.text_
function DeleteMessage_(chat,id,func)
tdcli_function ({
ID="DeleteMessages",
chat_id_=chat,
message_ids_=id
},func or dl_cb,nil)
end
if ChatType == 'sp' or ChatType == 'gp'  then
if DevAbs:get(LaricA.."Abs:Lock:MuteNames"..msg.chat_id_) then
if Manager(msg) then
if text and (text:match("^كتم (.*)$") or text:match("^كتم الاسم (.*)$")) then
local MuteName = text:match("^كتم اسم (.*)$") or text:match("^كتم الاسم (.*)$")
send(msg.chat_id_, msg.id_, '⌁︙تم كتم الاسم ↫ '..MuteName)
DevAbs:sadd(LaricA.."Abs:Mute:Names"..msg.chat_id_, MuteName)
end
if text and (text:match("^الغاء كتم (.*)$") or text:match("^الغاء كتم الاسم (.*)$")) then
local UnMuteName = text:match("^الغاء كتم اسم (.*)$") or text:match("^الغاء كتم الاسم (.*)$")
send(msg.chat_id_, msg.id_, '⌁︙تم الغاء كتم الاسم ↫ '..UnMuteName)
DevAbs:srem(LaricA.."Abs:Mute:Names"..msg.chat_id_, UnMuteName)
end
end
if text == "مسح الاسماء المكتومه" and Constructor(msg) then
DevAbs:del(LaricA.."Abs:Mute:Names"..msg.chat_id_)
send(msg.chat_id_, msg.id_, "⌁︙تم مسح الاسماء المكتومه")
end
if text == "الاسماء المكتومه" and Constructor(msg) then
local AllNames = DevAbs:smembers(LaricA.."Abs:Mute:Names"..msg.chat_id_)
Text = "\n⌁︙قائمة الاسماء المكتومه ↫ ⤈\n┉ ≈ ┉ ≈ ┉ ≈ ┉ ≈ ┉\n"
for k,v in pairs(AllNames) do
Text = Text..""..k.."~ : (["..v.."])\n"
end
if #AllNames == 0 then
Text = "⌁︙لاتوجد اسماء مكتومه"
end
send(msg.chat_id_, msg.id_, Text)
end
end
if not Manager(msg) and DevAbs:get(LaricA.."Abs:Lock:MuteNames"..msg.chat_id_) then
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
if result.id_ then 
LaricAName = ((result.first_name_ or "") .. (result.last_name_ or ""))
if LaricAName then 
LaricANames = DevAbs:smembers(LaricA.."Abs:Mute:Names"..msg.chat_id_) or ""
if LaricANames and LaricANames[1] then 
for i=1,#LaricANames do 
if LaricAName:match("(.*)("..LaricANames[i]..")(.*)") then 
DeleteMessage_(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
end
end
end,nil)
end

if Constructor(msg) then
if text == "تفعيل كتم الاسم" or text == "تفعيل كتم الاسماء" then
send(msg.chat_id_, msg.id_, '⌁︙تم التفعيل سيتم كتم العضو الذي يضع الاسماء المكتومه')
DevAbs:set(LaricA.."Abs:Lock:MuteNames"..msg.chat_id_,true)
end
if text == "تعطيل كتم الاسم" or text == "تعطيل كتم الاسماء" then
send(msg.chat_id_, msg.id_, '⌁︙تم تعطيل سيتم كتم العضو الذي يضع الاسماء المكتومه')
DevAbs:del(LaricA.."Abs:Lock:MuteNames"..msg.chat_id_)
end
end
end

end
return {
LaricA = MuteNames,
}