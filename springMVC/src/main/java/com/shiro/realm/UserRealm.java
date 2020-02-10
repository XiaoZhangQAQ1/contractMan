package com.shiro.realm;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;

import com.service.PermissionService;
import com.service.RoleService;
import com.service.UserService;
import com.shiro.entity.Permission;
import com.shiro.entity.Role;
import com.shiro.entity.User;

public class UserRealm extends AuthorizingRealm{
	@Autowired
	private UserService userService;
	@Autowired
	private RoleService roleService;
	@Autowired
	private PermissionService permissionService;
	//授权
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principal) {
		// TODO Auto-generated method stub
		//System.out.println("开始授权");
		User LoginUser = (User)principal.getPrimaryPrincipal();
		String uid = LoginUser.getUid();
		System.out.println(uid);
		if (uid!=null) {
			User user = userService.getUserByUid(uid);
			Set<Role> roles = roleService.getRolesByUid(user.getUid());
			Set<String> roleName = new HashSet<String>();
			Set<String> permissions = permissionService.getUrlById(user.getUid());
			SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
			if(roles!=null&&!roles.isEmpty()){
                for(Role role:roles){
                    roleName.add(role.getRoleName());
                }
            }
			//System.out.println(roleName);
			//System.out.println(permissions);
			info.setRoles(roleName);
			info.setStringPermissions(permissions);
            return info;
		}
		return null;
	}

	//认证
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
		// TODO Auto-generated method stub
		UsernamePasswordToken token2 = (UsernamePasswordToken)token;
		String uid = token2.getUsername();
//		System.out.println(uid);
		if (uid!=null&&!"".equals(uid)) {
			User user = userService.getUserByUid(uid);
//			System.out.println(user);
//			System.out.println(user.getRoleList());
//			for (Role role:user.getRoleList()) {
//				System.out.println(role.getRoleName());
//			}
			//将字符串转换为ByteSource实例
			ByteSource salt=ByteSource.Util.bytes(user.getSalt());
			if (user!= null) {
				return new SimpleAuthenticationInfo(user,user.getPassword(),salt,getName());
			}
		}
		System.out.println("用户不存在");
 		return null;
	}

}
