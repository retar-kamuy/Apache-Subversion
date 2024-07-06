FROM rockylinux:8 AS r8-systemd
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
    systemd-tmpfiles-setup.service ] || rm -f $i; done) \
    && rm -f /lib/systemd/system/multi-user.target.wants/* \
    && rm -f /etc/systemd/system/*.wants/* \
    && rm -f /lib/systemd/system/local-fs.target.wants/* \
    && rm -f /lib/systemd/system/sockets.target.wants/*udev* \
    && rm -f /lib/systemd/system/sockets.target.wants/*initctl* \
    && rm -f /lib/systemd/system/basic.target.wants/* \
    && rm -f /lib/systemd/system/anaconda.target.wants/*

FROM r8-systemd AS r8-systemd-httpd
RUN dnf -y install httpd httpd-tools \
    && dnf clean all \
    && systemctl enable httpd.service

FROM r8-systemd-httpd
RUN dnf -y install subversion mod_dav_svn \
    && echo ""                                  >> /etc/httpd/conf.modules.d/10-subversion.conf \
    && echo '<Location /svn>'                   >> /etc/httpd/conf.modules.d/10-subversion.conf \
    && echo '    DAV svn'                       >> /etc/httpd/conf.modules.d/10-subversion.conf \
    && echo '    SVNParentPath /var/www/svn/'   >> /etc/httpd/conf.modules.d/10-subversion.conf \
    && echo '    AuthType Basic'                >> /etc/httpd/conf.modules.d/10-subversion.conf \
    && echo '    AuthName "SVN Repository"'     >> /etc/httpd/conf.modules.d/10-subversion.conf \
    && echo '    Require valid-user'            >> /etc/httpd/conf.modules.d/10-subversion.conf \
    && echo '    AuthUserFile /var/svn/passwd'  >> /etc/httpd/conf.modules.d/10-subversion.conf \
    && echo '</Location>'                       >> /etc/httpd/conf.modules.d/10-subversion.conf \
    && mkdir -p /var/svn \
    && chown -R apache.apache /var/svn

CMD ["/usr/sbin/init"]
