<jsp:directive.include file="/WEB-INF/views/includes.jsp" />

<form id="portal_login" action="/PortalSascar/j_security_check" method="post">
        <input type="hidden" name="j_password" value="${j_password}"/>
        <input type="hidden" name="j_username" value="${j_username}"/>
</form>

<script type="text/javascript">
        var mobile = (/iphone|ipad|ipod|android|blackberry|mini|MSIE 10.0|Windows Phone 8.0|Trident\/6.0|IEMobile\/10.0|ARM|Touch|NOKIA|Lumia 920|windows\sce|palm/i
                        .test(navigator.userAgent.toLowerCase()));

        var isLoginAVL = "${SascarUser.loginAVL}";

        var perfil = "${SascarUser.perfil}";

        if (isLoginAVL == 'true') {

                var url_avl = "${url_avl}";

                parent.window.location.href = url_avl + '?id=${SascarUser.idSessao}';

        } else {
                if (mobile) {
                        if(perfil != 'RT'){

                                document.location = "/SascarPortalWeb/Satellite?pagename=SascarPortal_Corporativo/Login&operacaoNaoPermitida=true";

                        }else{
                                document.location = "/SascarPortalWeb/Satellite?pagename=SascarPortal_Corporativo/Mobile/${profilePath[SascarUser.perfil]}";
                        }

                } else {
                	if(${isLocalHost}){
                        parent.window.location.href = "/SascarPortalWeb/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}";
                	}else{
                        document.getElementById("portal_login").submit();
                	}
                }
        }

</script>