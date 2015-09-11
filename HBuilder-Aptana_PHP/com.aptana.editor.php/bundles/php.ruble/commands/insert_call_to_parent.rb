require 'ruble'

command t(:insert_call_to_parent) do |cmd|
  cmd.scope = 'source.php'
  cmd.trigger = 'source.php'
  cmd.output = :insert_as_snippet
  cmd.input = :document
  cmd.invoke =<<-EOF
#!/usr/bin/env php
<?php

$file = explode("\n", file_get_contents('php://stdin'));
$start = getenv('TM_LINE_NUMBER');

for ($i = $start - 1; $i > 0; $i--)
{
	$line = trim($file[$i]);
	switch(substr($line, 0, 1))
	{
		case '/':
		case '*':
		case '':
		continue;
		break;
	}

	if (preg_match('/function (.+?)\s*\((.*)\)/', $line, $matches))
	{
		if (isset($matches[2]))
		{
			$parameters = explode(',', $matches[2]);

			for($tabstop = 1; $tabstop <= count($parameters); ++$tabstop)
			{
				$parameter = str_replace('$', '\$', 
					preg_replace('/^(?:[a-z\s&]+)?(\$[^\s=]+).*$/i', '$1', 
						trim($parameters[$tabstop-1])
					)
				);
				$parameters[$tabstop-1] = "\${{$tabstop}:${parameter}}";
			}
		}
		else
		{
			$parameters = array();
		}

		echo 'parent::'.$matches[1].'(' . implode(', ', $parameters) . ');$0';
		break;
	}
}
?>
EOF
end
