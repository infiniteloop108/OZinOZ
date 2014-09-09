{Browse _}

declare
SAS = {Dictionary.new}

declare
proc {BindAdd X}
   {Dictionary.put SAS X [X _]}
end

declare
fun {RetrieveNodeSAS Exp1}
   local Node in
      Node={Dictionary.get SAS Exp1}
      if Node.1==Exp1 then Node
      else {RetrieveNodeSAS Node.1}
      end
   end
end

declare
fun {RetrievefromSAS Exp1}
   local Node in
      Node={RetrieveNodeSAS Exp1}
      Node.2.1
   end
end

declare
proc {UnifySAS Exp1 Exp2}
   local NodeX NodeY in
      NodeX = {RetrieveNodeSAS Exp1}
      NodeY = {RetrieveNodeSAS Exp2}
      {Browse NodeX.2.1}
      case NodeX.2.1
      of _ then
	 {Browse NodeY.1}
	 {Dictionary.put SAS NodeX.1 [NodeY.1 _]}
      else case NodeY.2.1
	   of _ then {Dictionary.put SAS NodeY.1 [NodeX.1 _]}
	   else case NodeX.2.1 == NodeY.2.1
		of true then
		   {Dictionary.put SAS NodeX.1 [NodeY.1 _]}
		   {Dictionary.put SAS NodeY.1 [NodeY.1 NodeY.2.1]}
		[] false then
		   {Browse "Illegal assignment"}
		end
	   end
      end
   end
end

declare
proc {Bindval Exp Val}
   local NodeX in
      NodeX={RetrieveNodeSAS Exp}
      if NodeX.2.1 == _ then {Dictionary.put SAS NodeX.1 [NodeX.1 Val]}
      elseif NodeX.2.1 == Val then skip
      else {Browse 'Illegal assignment'}
      end
   end
end

{Dictionary.reset SAS}

{BindAdd 1}
{BindAdd 2}
{BindAdd 3}

{Browse {RetrieveNodeSAS 1}}

{Browse {Dictionary.entries SAS}}

{UnifySAS 1 2}
{Browse {Dictionary.entries SAS}}