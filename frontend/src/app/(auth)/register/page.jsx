"use client";

import React from "react";
import { useRouter } from "next/navigation";
import { User, Users, Shield } from 'lucide-react'; // Import icons from Heroicons
import "react-toastify/dist/ReactToastify.css";

const RegisterRedirect = () => {
    const router = useRouter();

    // Redirects to the appropriate registration page based on the selected role
    const redirectToRolePage = (role) => {
        switch (role) {
            case "teamMember":
                router.push("/register/team-member");
                break;
            case "teamManager":
                router.push("/register/team-manager");
                break;
            case "admin":
                router.push("/register/admin");
                break;
            default:
                break;
        }
    };

    return (
        <div className="min-h-screen flex items-center justify-center">
            <div className="bg-white p-8 rounded-lg shadow-lg w-full max-w-md">
                <h2 className="text-4xl font-bold mb-6 text-center text-[#6975fc]">
                    Register As
                </h2>
                <p className="mb-4 text-center text-gray-700">
                    Please select your role to continue to the registration page.
                </p>
                <div className="flex flex-col space-y-4">
                    <button
                        onClick={() => redirectToRolePage("teamMember")}
                        className="btn btn-primary w-full flex items-center justify-center gap-2 text-slate-50"
                    >
                        <User className="w-6 h-6 text-white" />
                        Register as Team Member
                    </button>
                    <button
                        onClick={() => redirectToRolePage("teamManager")}
                        className="btn btn-primary w-full flex items-center justify-center gap-2 text-slate-50"
                    >
                        <Users className="w-6 h-6 text-white" />
                        Register as Team Manager
                    </button>
                    <button
                        onClick={() => redirectToRolePage("admin")}
                        className="btn btn-primary w-full flex items-center justify-center gap-2 text-slate-50"
                    >
                        <Shield className="w-6 h-6 text-white" />
                        Register as Admin
                    </button>
                </div>
            </div>
        </div>
    );
};

export default RegisterRedirect;
