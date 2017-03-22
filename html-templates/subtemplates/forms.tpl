{template validationErrors errors}
    {if count($errors) > 0}
        <div class="error notify">
            <ul class="validation-errors">
                {foreach $errors error}
                    <li>{$error}</li>
                {/foreach}
            </ul>
        </div>
    {/if}
{/template}

{template labeledField html type=text label='' error='' hint='' required=false class=null}
    <label class="field {$type}-field {if $error}has-error{/if} {if $required}is-required{/if} {$class}">
        {if $label}<span class="field-label">{$label}</span>{/if}

        {$html}

        {if $error}<p class="error-text">{$error}</p>{/if}
        {if $hint}<p class="hint">{$hint}</p>{/if}
    </label>
{/template}

{template field inputName label='' error='' type=text placeholder='' hint='' required=false autofocus=false attribs='' default=null class=null fieldClass=null}
    {capture assign=html}
        <input type="{$type}"
            class="field-control {$class}"
            name="{$inputName|escape}"
            {if $placeholder}placeholder="{$placeholder|escape}"{/if}
            {if $autofocus}autofocus{/if}
            {if $required}required aria-required="true"{/if}
            {$attribs}
            value="{refill field=$inputName default=$default}">
    {/capture}

    {labeledField html=$html type=$type label=$label error=$error hint=$hint required=$required class=$fieldClass}
{/template}

{template checkbox inputName value label='' error='' hint='' attribs='' default=null class=null unsetValue=null}
    {capture assign=html}
        <input type="checkbox"
            class="field-control {$class}"
            name="{$inputName|escape}"
            value="{$value|escape}"
            {$attribs}
            {refill field=$inputName default=$default checked=$value}>
    {/capture}

    {if $unsetValue !== null}
        <input type="hidden" name="{$inputName|escape}" value="{$unsetValue|escape}">
    {/if}

    {labeledField html=$html type=checkbox label=$label error=$error hint=$hint required=$required}
{/template}

{template textarea inputName label='' error='' placeholder='' hint='' required=false attribs='' default=null}
    {capture assign=html}
        <textarea
            class="field-control"
            name="{$inputName|escape}"
            {if $placeholder}placeholder="{$placeholder|escape}"{/if}
            {if $required}required aria-required="true"{/if}
            {$attribs}
        >{refill field=$inputName default=$default}</textarea>
    {/capture}

    {labeledField html=$html type=textarea label=$label error=$error hint=$hint required=$required}
{/template}

{template loginField}{field inputName=_LOGIN[username] label=Username required=true attribs='autofocus autocapitalize="none" autocorrect="off" spellcheck="false"' hint='You can also log in with your email address.'}{/template}
{template passwordField}{field inputName=_LOGIN[password] label=Password hint='<a href="/register/recover">Forgot?</a>' required=true refill=false type=password}{/template}
{template rememberMeField}{if $.cookies['username'] !== null}{$atts = 'CHECKED'}{/if}{checkbox _LOGIN[remember] '' attribs=$atts label='Remember Me'}{/template}
